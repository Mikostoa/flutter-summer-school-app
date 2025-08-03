import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_places/assets/images/app_svg_icons.dart';
import 'package:surf_places/assets/strings/app_strings.dart';
import 'package:surf_places/features/common/domain/enitities/place_entity.dart';
import 'package:surf_places/features/common/domain/repositories/i_favorites_repository.dart';
import 'package:surf_places/features/place_detail/ui/screens/place_detail_screen_builder.dart';
import 'package:surf_places/uikit/images/svg_picture_widget.dart';
import 'package:surf_places/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_places/uikit/themes/text/app_text_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);
    final favoritesRepository = context.read<IFavoritesRepository>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (_, __) => [
              SliverAppBar(
                title: Center(
                  child: const Text(AppStrings.placesScreenBottomNavFavorites),
                ),
                floating: true,
                snap: true,
              ),
            ],
        body: ValueListenableBuilder<List<PlaceEntity>>(
          valueListenable: favoritesRepository.favoritesListenable,
          builder: (context, favorites, _) {
            if (favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPictureWidget(
                      AppSvgIcons.icGo,
                      width: 64,
                      height: 64,
                      color: colorTheme.inactive,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.favoritesEmpty,
                      style: textTheme.subtitle.copyWith(
                        color: colorTheme.inactive,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final place = favorites[index];
                return Dismissible(
                  key: Key(place.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                      color: colorTheme.error,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    favoritesRepository.removeFavorite(place);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${place.name} удалено из избранного'),
                        action: SnackBarAction(
                          label: 'Отмена',
                          onPressed: () {
                            favoritesRepository.toggleFavorite(place);
                          },
                        ),
                      ),
                    );
                  },
                  child: _FavoritePlaceCard(
                    place: place,
                    onTap: () => _navigateToPlaceDetail(context, place),
                    onShare: () {
                      // TODO: Реализовать функционал "Поделиться"
                    },
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            );
          },
        ),
      ),
    );
  }

  void _navigateToPlaceDetail(BuildContext context, PlaceEntity place) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaceDetailScreenBuilder(place: place),
      ),
    );
  }
}

class _FavoritePlaceCard extends StatelessWidget {
  final PlaceEntity place;
  final VoidCallback onTap;
  final VoidCallback onShare;

  const _FavoritePlaceCard({
    required this.place,
    required this.onTap,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);
    const cardHeight = 188.0;
    const imageHeight = 96.0;

    return SizedBox(
      height: cardHeight,
      child: Material(
        color: colorTheme.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: imageHeight,
                      child: Image.network(
                        place.images.firstOrNull ?? '',
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) =>
                                Center(child: Text(AppStrings.noPhoto)),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Text(
                        place.placeType.name.toLowerCase(),
                        style: textTheme.smallBold.copyWith(
                          color: colorTheme.neutralWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: textTheme.text.copyWith(
                          color: colorTheme.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        place.description,
                        style: textTheme.small.copyWith(
                          color: colorTheme.textSecondaryVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: onTap),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: SvgPictureWidget(
                  AppSvgIcons.icShare,
                  color: colorTheme.neutralWhite,
                ),
                onPressed: onShare,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
