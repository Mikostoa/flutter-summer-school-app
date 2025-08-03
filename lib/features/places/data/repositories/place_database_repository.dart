import 'package:sqflite/sqflite.dart';
import 'package:surf_places/core/data/database/database_helper.dart';
import 'package:surf_places/features/common/domain/enitities/place_entity.dart';
import 'package:surf_places/features/common/domain/enitities/place_type_entity.dart';

class PlaceDatabaseRepository {
  final DatabaseHelper _databaseHelper;

  PlaceDatabaseRepository(this._databaseHelper);

  Future<void> savePlaces(List<PlaceEntity> places) async {
    final db = await _databaseHelper.database;
    final batch = db.batch();

    // Clear old data first
    await _databaseHelper.clearDatabase();

    for (final place in places) {
      batch.insert('places', {
        'id': place.id,
        'name': place.name,
        'description': place.description,
        'placeType': place.placeType.name,
        'lat': place.lat,
        'lon': place.lon,
      });

      for (final imageUrl in place.images) {
        batch.insert('place_images', {
          'placeId': place.id,
          'url': imageUrl,
        });
      }
    }

    await batch.commit(noResult: true);
  }

  Future<List<PlaceEntity>> getPlaces() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> placesMaps = await db.query('places');
    
    final List<PlaceEntity> places = [];
    
    for (final placeMap in placesMaps) {
      final images = await db.query(
        'place_images',
        where: 'placeId = ?',
        whereArgs: [placeMap['id']],
      );
      
      places.add(PlaceEntity(
        id: placeMap['id'],
        name: placeMap['name'],
        description: placeMap['description'],
        placeType: PlaceTypeEntity.values.firstWhere(
          (e) => e.name == placeMap['placeType'],
          orElse: () => PlaceTypeEntity.other,
        ),
        images: images.map((e) => e['url'] as String).toList(),
        lat: placeMap['lat'],
        lon: placeMap['lon'],
      ));
    }
    
    return places;
  }

  Future<int> getPlacesCount() async {
    final db = await _databaseHelper.database;
    return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM places')
    ) ?? 0;
  }
}