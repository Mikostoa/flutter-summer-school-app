import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_places/assets/images/app_svg_icons.dart'; // Убедитесь, что путь правильный
import 'package:surf_places/features/onboarding/ui/screens/onboarding_screen_builder.dart';
import 'package:surf_places/features/tabs_screen/tabs_screen.dart'; // Убедитесь, что путь к TabsScreen правильный
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:surf_places/uikit/images/svg_picture_widget.dart';

/// Экран заставки.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Ключ для SharedPreferences, чтобы проверить, был ли показан онбординг
  static const String _onboardingCompletedKey = 'onboarding_completed';

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  /// Определяет, куда нужно перейти после сплэш-скрина.
  Future<void> _navigateAfterDelay() async {
    // Ждем 2 секунды
    await Future.delayed(const Duration(seconds: 2));

    // Проверяем, завершен ли онбординг
    final prefs = await SharedPreferences.getInstance();
    final isOnboardingCompleted =
        prefs.getBool(_onboardingCompletedKey) ?? false;

    // Переход к нужному экрану
    // Используем context.mounted для проверки, что виджет еще в дереве
    if (!mounted) return;
    if (isOnboardingCompleted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const TabsScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreenBuilder(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // Или цвет из вашей темы
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFCDD3D), Color(0xFF4CAF50)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          // Используйте ваш SVG логотип
          child: SvgPictureWidget(
            AppSvgIcons.icSplashLogo,
            color: Colors.white,
            width: 150,
            height: 150,
          ), // Или SvgPicture.asset если используете flutter_svg и нужен SVG
          // Если у вас нет готового виджета для SVG логотипа, временно можно использовать
          // Icon или просто Container с цветом
          // child: Icon(Icons.location_on, size: 100, color: Colors.blue), // Пример
        ),
      ),
    );
  }
}
