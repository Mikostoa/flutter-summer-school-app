// lib/features/search/ui/screens/search_model.dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:surf_places/core/domain/entities/result/result.dart';
import 'package:surf_places/features/common/domain/enitities/place_entity.dart';
import 'package:surf_places/features/search/domain/repositories/i_search_repository.dart';
import 'package:surf_places/features/search/domain/search_state.dart';

class SearchModel implements ISearchModel {
  final ISearchRepository _searchRepository;
  final ValueNotifier<SearchState> _state = ValueNotifier(
    const SearchStateInitial(),
  );
  Timer? _searchTimer;

  SearchModel(this._searchRepository);

  @override
  ValueNotifier<SearchState> get stateNotifier => _state;

  @override
  void search(String query) {
    // Отменяем предыдущий таймер, если он есть
    _searchTimer?.cancel();

    if (query.length < 3) {
      _state.value = const SearchStateInitial();
      return;
    }

    _state.value = const SearchStateLoading();

    // Запускаем новый таймер
    _searchTimer = Timer(const Duration(milliseconds: 500), () async {
      final result = await _searchRepository.searchPlaces(query);

      switch (result) {
        case ResultOk(:final data as List<PlaceEntity>):
          _state.value =
              data.isEmpty
                  ? const SearchStateEmpty()
                  : SearchStateResults(data);
        case ResultFailed(:final error):
          _state.value = SearchStateError(error.toString());
      }
    });
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    _state.dispose();
  }
}

abstract interface class ISearchModel {
  ValueNotifier<SearchState> get stateNotifier;
  void search(String query);
  void dispose();
}
