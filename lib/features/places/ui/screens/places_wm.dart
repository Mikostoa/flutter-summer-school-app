import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_places/features/common/domain/enitities/place_entity.dart';
import 'package:surf_places/features/common/domain/repositories/i_favorites_repository.dart';
import 'package:surf_places/features/place_detail/ui/screens/place_detail_screen_builder.dart';
import 'package:surf_places/features/places/domain/enitites/places_state.dart';
import 'package:surf_places/features/places/ui/screens/places_model.dart';

/// WM для экрана списка мест.
abstract class IPlacesWM {
  /// [ValueListenable] состояния экрана мест.
  ValueListenable<PlacesState> get placesStateListenable;

  /// Освобождение ресурсов.
  void dispose();

  /// Обработчик нажатия на карточку места.
  void onPlacePressed(BuildContext context, PlaceEntity place);

  /// Обработчик нажатия на кнопку "лайк".
  void onLikePressed(PlaceEntity place);

  /// Проверяет, добавлено ли место в избранное.
  bool isFavorite(PlaceEntity place);

  /// Загрузка списка мест.
  Future<void> loadPlaces();
}

/// Реализация WM для экрана списка мест.
class PlacesWM implements IPlacesWM {
  final IPlacesModel _model;
  final IFavoritesRepository _favoritesRepository;

  /// @nodoc
  PlacesWM(this._model, this._favoritesRepository) {
    _model.getPlaces();
  }

  @override
  ValueListenable<PlacesState> get placesStateListenable => _model.placesStateListenable;

  @override
  void dispose() => _model.dispose();

  @override
  void onPlacePressed(BuildContext context, PlaceEntity place) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlaceDetailScreenBuilder(place: place)));
  }

  @override
  void onLikePressed(PlaceEntity place) {
    _favoritesRepository.toggleFavorite(place);
  }

  @override
  bool isFavorite(PlaceEntity place) {
    return _favoritesRepository.isFavorite(place);
  }

  @override
  Future<void> loadPlaces() => _model.getPlaces();
}
