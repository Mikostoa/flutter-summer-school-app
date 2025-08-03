import 'package:flutter/material.dart';
import 'package:surf_places/features/search/domain/search_state.dart';
import 'package:surf_places/features/search/ui/screens/search_model.dart';

class SearchWM implements ISearchWM {
  final ISearchModel _model;

  SearchWM(this._model);

  @override
  ValueNotifier<SearchState> get stateNotifier => _model.stateNotifier;

  @override
  void search(String query) {
    _model.search(query);
  }

  @override
  void dispose() {
    _model.dispose();
  }
}

abstract interface class ISearchWM {
  ValueNotifier<SearchState> get stateNotifier;
  void search(String query);
  void dispose();
}