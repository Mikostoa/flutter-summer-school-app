import 'package:flutter/material.dart';
import 'package:surf_places/assets/images/app_svg_icons.dart';
import 'package:surf_places/assets/strings/app_strings.dart';
import 'package:surf_places/features/common/domain/enitities/place_entity.dart';
import 'package:surf_places/features/place_detail/ui/screens/place_detail_screen_builder.dart';
import 'package:surf_places/features/search/ui/screens/search_wm.dart';
import 'package:surf_places/features/search/domain/search_state.dart';
import 'package:surf_places/uikit/images/svg_picture_widget.dart';
import 'package:surf_places/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_places/uikit/themes/text/app_text_theme.dart';

class SearchScreen extends StatefulWidget {
  final ISearchWM wm;

  const SearchScreen({required this.wm, super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    widget.wm.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    widget.wm.search(_searchController.text);
  }

  void _navigateToPlaceDetail(PlaceEntity place) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaceDetailScreenBuilder(place: place),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(colorTheme, textTheme),
      ),
      body: ValueListenableBuilder<SearchState>(
        valueListenable: widget.wm.stateNotifier,
        builder: (context, state, _) {
          return switch (state) {
            SearchStateInitial() => _buildInitialState(colorTheme, textTheme),
            SearchStateLoading() => _buildLoadingState(),
            SearchStateEmpty() => _buildEmptyState(colorTheme, textTheme),
            SearchStateError(:final message) => _buildErrorState(message, colorTheme, textTheme),
            SearchStateResults(:final places) => _buildResults(places, colorTheme, textTheme),
          };
        },
      ),
    );
  }

  Widget _buildSearchField(AppColorTheme colorTheme, AppTextTheme textTheme) {
    return TextField(
      controller: _searchController,
      focusNode: _focusNode,
      autofocus: true,
      decoration: InputDecoration(
        hintText: AppStrings.searchHint,
        hintStyle: textTheme.text.copyWith(color: colorTheme.textSecondaryVariant),
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search, color: colorTheme.textSecondary),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: SvgPictureWidget(
                  AppSvgIcons.icClear,
                  color: colorTheme.textSecondary,
                ),
                onPressed: () {
                  _searchController.clear();
                  _focusNode.requestFocus();
                },
              )
            : null,
      ),
      style: textTheme.text.copyWith(color: colorTheme.textPrimary),
    );
  }

  Widget _buildInitialState(AppColorTheme colorTheme, AppTextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPictureWidget(
            AppSvgIcons.icSearch,
            color: colorTheme.inactive,
            width: 64,
            height: 64,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.searchInitialTitle,
            style: textTheme.subtitle.copyWith(color: colorTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.searchInitialDescription,
            style: textTheme.small.copyWith(color: colorTheme.textSecondaryVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState(AppColorTheme colorTheme, AppTextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPictureWidget(
            AppSvgIcons.icEmptySearch,
            color: colorTheme.inactive,
            width: 64,
            height: 64,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.searchEmptyTitle,
            style: textTheme.subtitle.copyWith(color: colorTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.searchEmptyDescription,
            style: textTheme.small.copyWith(color: colorTheme.textSecondaryVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message, AppColorTheme colorTheme, AppTextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPictureWidget(
            AppSvgIcons.icNetworkException,
            color: colorTheme.error,
            width: 64,
            height: 64,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.searchErrorTitle,
            style: textTheme.subtitle.copyWith(color: colorTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: textTheme.small.copyWith(color: colorTheme.error),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResults(List<PlaceEntity> places, AppColorTheme colorTheme, AppTextTheme textTheme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: place.images.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      place.images.first,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(Icons.photo, size: 56, color: colorTheme.inactive),
                    ),
                  )
                : Icon(Icons.photo, size: 56, color: colorTheme.inactive),
            title: Text(place.name, style: textTheme.text.copyWith(color: colorTheme.textPrimary)),
            subtitle: Text(
              place.placeType.name.toLowerCase(),
              style: textTheme.small.copyWith(color: colorTheme.textSecondaryVariant),
            ),
            onTap: () => _navigateToPlaceDetail(place),
          ),
        );
      },
    );
  }
}