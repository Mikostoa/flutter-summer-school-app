import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_places/assets/images/app_svg_icons.dart';
import 'package:surf_places/assets/strings/app_strings.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_wm.dart';
import 'package:surf_places/uikit/buttons/text_button_widget.dart';
import 'package:surf_places/uikit/images/svg_picture_widget.dart';
import 'package:surf_places/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_places/uikit/themes/colors/app_colors.dart';
import 'package:surf_places/uikit/themes/text/app_text_style.dart';
import 'package:surf_places/uikit/themes/text/app_text_theme.dart';

/// Экран онбоардинга.
class OnboardingScreen extends StatelessWidget {
  final IOnboardingWM wm;

  const OnboardingScreen({required this.wm, super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Scaffold(
      backgroundColor: colorTheme.scaffold, // Используем цвет фона из темы
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: wm.pageController,
              onPageChanged: wm.onPageChanged,
              children: const [
                _OnboardingPage(
                  imageAsset: AppSvgIcons.onboardingPage1,
                  title: AppStrings.onboardingPage1Title,
                  description: AppStrings.onboardingPage1Description,
                ),
                _OnboardingPage(
                  imageAsset: AppSvgIcons.onboardingPage2,
                  title: AppStrings.onboardingPage2Title,
                  description: AppStrings.onboardingPage2Description,
                ),
                _OnboardingPage(
                  imageAsset: AppSvgIcons.onboardingPage3,
                  title: AppStrings.onboardingPage3Title,
                  description: AppStrings.onboardingPage3Description,
                ),
              ],
            ),
            // Кнопка "Пропустить"
            Positioned(
              top: 16,
              right: 16,
              child: ValueListenableBuilder<bool>(
                valueListenable: wm.isLastPageNotifier,
                builder: (context, isLastPage, child) {
                  // Скрываем кнопку "Пропустить" на последней странице
                  return Visibility(
                    visible: !isLastPage,
                    child: TextButtonWidget(
                      title: AppStrings.onboardingSkipButton,
                      onPressed: wm.onSkipPressed,
                      color: AppColors.colorBlackGreen2, // Цвет текста кнопки
                    ),
                  );
                },
              ),
            ),
            // Индикаторы и кнопка "Далее/На старт"
            Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Column(
                children: [
                  // Индикаторы точками
                  const _DotsIndicator(),
                  const SizedBox(height: 32),
                  // Кнопка "Далее" / "На старт"
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: wm.isLastPageNotifier,
                        builder: (context, isLastPage, child) {
                          return FilledButton(
                            onPressed: wm.onNextPressed,
                            style: FilledButton.styleFrom(
                              backgroundColor:
                                  colorTheme.accent, // Цвет кнопки из темы
                              foregroundColor:
                                  colorTheme.neutralWhite, // Цвет текста кнопки
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              isLastPage
                                  ? AppStrings.onboardingStartButton
                                  : AppStrings.onboardingNextButton,
                              style: textTheme.button,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Виджет одной страницы онбоардинга.
class _OnboardingPage extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;

  const _OnboardingPage({
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Изображение SVG
          SvgPictureWidget(
            imageAsset,
            height: 104, // Установите желаемую высоту
            // width: double.infinity, // Растягиваем по ширине
            fit: BoxFit.contain, // Или BoxFit.fitWidth
          ),
          const SizedBox(height: 48),
          // Заголовок
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.title.value,
          ),
          const SizedBox(height: 16),
          // Описание
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyle.small.value,
          ),
        ],
      ),
    );
  }
}

/// Виджет точечного индикатора.
class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator();

  @override
  Widget build(BuildContext context) {
    // Получаем WM через контекст, чтобы получить доступ к текущей странице
    final wm = context.watch<IOnboardingWM>();
    final colorTheme = AppColorTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return ValueListenableBuilder<int>(
          valueListenable: wm.currentPageNotifier,
          builder: (context, currentPage, child) {
            // Скрываем кнопку "Пропустить" на последней странице
            return AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ), // Длительность анимации
              curve: Curves.easeInOut, // Тип анимационной кривой
              width:
                  currentPage == index
                      ? 24
                      : 8, // Ширина активной/неактивной точки
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color:
                    currentPage == index
                        ? colorTheme
                            .accent // Цвет активной точки
                        : colorTheme.inactive, // Цвет неактивной точки
              ),
            );
          },
        );
      }),
    );
  }
}
