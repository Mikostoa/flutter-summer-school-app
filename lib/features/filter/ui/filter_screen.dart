import 'package:flutter/material.dart';
import 'package:surf_places/assets/images/app_svg_icons.dart';
import 'package:surf_places/assets/strings/app_strings.dart';
import 'package:surf_places/uikit/buttons/text_button_widget.dart';
import 'package:surf_places/uikit/images/svg_picture_widget.dart';
import 'package:surf_places/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_places/uikit/themes/colors/app_colors.dart';
import 'package:surf_places/uikit/themes/text/app_text_theme.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _currentValue = 50.0;
  int? _selectedCategoryIndex;

  static const _icList = [
    AppSvgIcons.icHotel,
    AppSvgIcons.icRestaurant,
    AppSvgIcons.icOther,
    AppSvgIcons.icPark,
    AppSvgIcons.icMuseum,
    AppSvgIcons.icCafe,
  ];

  static const _namePlaceList = [
    AppStrings.hotel,
    AppStrings.restaurant,
    AppStrings.other,
    AppStrings.park,
    AppStrings.museum,
    AppStrings.cafe,
  ];

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [TextButtonWidget(onPressed: () {}, title: 'Очистить')],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(AppStrings.categories, style: textTheme.subtitle),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 1.0,
                          ),
                      itemCount: _icList.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedCategoryIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategoryIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color:
                                      isSelected
                                          ? colorTheme.accent
                                          : AppColors.colorBlackGreen,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SvgPictureWidget(
                                    _icList[index],
                                    width: 16,
                                    height: 16,
                                    color:
                                        isSelected
                                            ? colorTheme.neutralWhite
                                            : null,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _namePlaceList[index],
                                // style: isSelected
                                //     ? textTheme.body?.copyWith(
                                //         color: colorTheme.accent,
                                //         fontWeight: FontWeight.bold,
                                //       )
                                //     : textTheme.body,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Text(AppStrings.distance, style: textTheme.subtitle),
                    const SizedBox(height: 16),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: colorTheme.accent,
                        inactiveTrackColor: colorTheme.secondary,
                        thumbColor: colorTheme.accent,
                        overlayColor: colorTheme.accent.withOpacity(0.2),
                        valueIndicatorColor: colorTheme.accent,
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: Slider(
                        value: _currentValue,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        label: "${_currentValue.round()} км",
                        onChanged: (double value) {
                          setState(() {
                            _currentValue = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "0 км",
                          // style: textTheme.caption,
                        ),
                        Text(
                          "100 км",
                          // style: textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // Фильтрация по выбранным параметрам
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorTheme.accent,
                  foregroundColor: colorTheme.neutralWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(AppStrings.showResults, style: textTheme.button),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
