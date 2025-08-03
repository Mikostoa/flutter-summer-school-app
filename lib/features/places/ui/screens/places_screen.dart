import 'package:flutter/material.dart';
import 'package:surf_places/assets/images/app_svg_icons.dart';
import 'package:surf_places/assets/strings/app_strings.dart';
import 'package:surf_places/features/filter/ui/filter_screen.dart';
import 'package:surf_places/features/places/domain/enitites/places_state.dart';
import 'package:surf_places/features/places/ui/screens/places_wm.dart';
import 'package:surf_places/features/places/ui/widgets/place_card_widget.dart';
import 'package:surf_places/features/search/ui/screens/search_screen_builder.dart';
import 'package:surf_places/uikit/images/svg_picture_widget.dart';
import 'package:surf_places/uikit/themes/colors/app_color_theme.dart';

/// Экран списка мест.
class PlacesScreen extends StatelessWidget {
  /// WM.
  final IPlacesWM wm;

  const PlacesScreen({required this.wm, super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    return Scaffold(
      body: ValueListenableBuilder<PlacesState>(
        valueListenable: wm.placesStateListenable,
        builder: (context, places, _) {
          return NestedScrollView(
            headerSliverBuilder:
                (_, __) => [
                  SliverAppBar(
                    title: Center(
                      child: const Text(AppStrings.placesScreenAppBarTitle),
                    ),
                    floating: true,
                    snap: true,
                  ),
                ],
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchScreenBuilder(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      color: colorTheme.background,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: SvgPictureWidget(AppSvgIcons.icSearch),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Container(
                              child: Text(AppStrings.searchHint),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            icon: SvgPictureWidget(
                              AppSvgIcons.icFilter,
                              color: colorTheme.accent,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const FilterScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: RefreshIndicator.adaptive(
                    onRefresh: wm.loadPlaces,
                    child: switch (places) {
                      PlacesStateLoading() => Center(
                        child: Text(AppStrings.placesLoading),
                      ),
                      PlacesStateFailure(:final failure) => Center(
                        child: Text('${AppStrings.placesError}$failure'),
                      ),
                      PlacesStateData(:final places) => ListView.separated(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 16,
                          right: 16,
                          bottom: 32,
                        ),
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          final likedPlace = places[index];
                          return PlaceCardWidget(
                            place: likedPlace.place,
                            onCardTap:
                                () => wm.onPlacePressed(
                                  context,
                                  likedPlace.place,
                                ),
                            onLikeTap: () => wm.onLikePressed(likedPlace.place),
                            isFavorite: likedPlace.isFavorite,
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 24),
                      ),
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
