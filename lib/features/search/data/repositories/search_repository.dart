// lib/features/search/data/repositories/search_repository.dart
import 'package:surf_places/api/service/api_client.dart';
import 'package:surf_places/core/data/repositories/base_repository.dart';
import 'package:surf_places/core/domain/entities/result/request_operation.dart';
import 'package:surf_places/features/common/data/converters/place_converter.dart';
import 'package:surf_places/features/common/domain/enitities/place_entity.dart';
import 'package:surf_places/features/search/domain/repositories/i_search_repository.dart';

final class SearchRepository extends BaseRepository implements ISearchRepository {
  final ApiClient _apiClient;
  final IPlaceDtoToEntityConverter _placeConverter;

  SearchRepository({
    required ApiClient apiClient,
    required IPlaceDtoToEntityConverter placeConverter,
  })  : _apiClient = apiClient,
        _placeConverter = placeConverter;

  @override
  RequestOperation<List<PlaceEntity>> searchPlaces(String query) {
    return makeApiCall(() async {
      // В реальном приложении здесь будет вызов API с фильтрацией
      final allPlaces = await _apiClient.getPlaces();
      final filteredPlaces = allPlaces.where((place) {
        return place.name.toLowerCase().contains(query.toLowerCase()) ||
            place.description.toLowerCase().contains(query.toLowerCase());
      }).toList();

      return _placeConverter.convertMultiple(filteredPlaces).toList();
    });
  }
}