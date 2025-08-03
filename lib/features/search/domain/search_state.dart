import 'package:flutter/foundation.dart';
import 'package:surf_places/features/common/domain/enitities/place_entity.dart';

@immutable
sealed class SearchState {
  const SearchState();
}

final class SearchStateInitial extends SearchState {
  const SearchStateInitial();
}

final class SearchStateLoading extends SearchState {
  const SearchStateLoading();
}

final class SearchStateEmpty extends SearchState {
  const SearchStateEmpty();
}

final class SearchStateError extends SearchState {
  final String message;
  const SearchStateError(this.message);
}

final class SearchStateResults extends SearchState {
  final List<PlaceEntity> places;
  const SearchStateResults(this.places);
}