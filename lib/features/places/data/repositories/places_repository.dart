import 'package:surf_places/api/service/api_client.dart';
import 'package:surf_places/core/data/repositories/base_repository.dart';
import 'package:surf_places/core/domain/entities/result/request_operation.dart';
import 'package:surf_places/features/common/data/converters/place_converter.dart';
import 'package:surf_places/features/common/domain/enitities/place_entity.dart';
import 'package:surf_places/features/places/data/repositories/place_database_repository.dart';
import 'package:surf_places/features/places/domain/reposiotries/i_places_repository.dart';

final class PlacesRepository extends BaseRepository implements IPlacesRepository {
  final ApiClient _apiClient;
  final IPlaceDtoToEntityConverter _placeDtoToEntityConverter;
  final PlaceDatabaseRepository _placeDatabaseRepository;

  PlacesRepository({
    required ApiClient apiClient, 
    required IPlaceDtoToEntityConverter placeDtoToEntityConverter,
    required PlaceDatabaseRepository placeDatabaseRepository,
  }) : _apiClient = apiClient,
       _placeDtoToEntityConverter = placeDtoToEntityConverter,
       _placeDatabaseRepository = placeDatabaseRepository;

  @override
  RequestOperation<List<PlaceEntity>> getPlaces() {
    return makeApiCall<List<PlaceEntity>>(() async {
      final cachedPlaces = await _placeDatabaseRepository.getPlaces();
      if (cachedPlaces.isNotEmpty) {
        return cachedPlaces;
      }

      final placesDtos = await _apiClient.getPlaces();
      final placesEntities = _placeDtoToEntityConverter
          .convertMultiple(placesDtos)
          .toList();
      
      await _placeDatabaseRepository.savePlaces(placesEntities);
      
      return placesEntities;
    });
  }
}