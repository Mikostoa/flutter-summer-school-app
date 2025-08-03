// lib/features/search/domain/repositories/i_search_repository.dart
import 'package:surf_places/core/domain/entities/result/request_operation.dart';
import 'package:surf_places/features/common/domain/enitities/place_entity.dart';

abstract interface class ISearchRepository {
  RequestOperation<List<PlaceEntity>> searchPlaces(String query);
}