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
      backgroundColor: colorTheme.scaffold,
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

            Positioned(
              top: 16,
              right: 16,
              child: ValueListenableBuilder<bool>(
                valueListenable: wm.isLastPageNotifier,
                builder: (context, isLastPage, child) {
                 
                  return Visibility(
                    visible: !isLastPage,
                    child: TextButtonWidget(
                      title: AppStrings.onboardingSkipButton,
                      onPressed: wm.onSkipPressed,
                      color: AppColors.colorBlackGreen2, 
                    ),
                  );
                },
              ),
            ),
          
            Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Column(
                children: [
           
                  const _DotsIndicator(),
                  const SizedBox(height: 32),
             
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
                                  colorTheme.accent, 
                              foregroundColor:
                                  colorTheme.neutralWhite, 
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPictureWidget(
            imageAsset,
            height: 104,
            fit: BoxFit.contain, 
          ),
          const SizedBox(height: 48),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.title.value,
          ),
          const SizedBox(height: 16),
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
    final wm = context.watch<IOnboardingWM>();
    final colorTheme = AppColorTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return ValueListenableBuilder<int>(
          valueListenable: wm.currentPageNotifier,
          builder: (context, currentPage, child) {
            return AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ), 
              curve: Curves.easeInOut, 
              width:
                  currentPage == index
                      ? 24
                      : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color:
                    currentPage == index
                        ? colorTheme
                            .accent 
                        : colorTheme.inactive,
              ),
            );
          },
        );
      }),
    );
  }
}
