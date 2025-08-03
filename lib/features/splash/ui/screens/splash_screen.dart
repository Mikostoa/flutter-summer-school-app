import 'package:flutter/material.dart';
import 'package:surf_places/assets/images/app_svg_icons.dart'; 
import 'package:surf_places/features/onboarding/ui/screens/onboarding_screen_builder.dart';
import 'package:surf_places/features/tabs_screen/tabs_screen.dart'; 
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
  static const String _onboardingCompletedKey = 'onboarding_completed';

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  /// Определяет, куда нужно перейти после сплэш-скрина.
  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final isOnboardingCompleted =
        prefs.getBool(_onboardingCompletedKey) ?? false;

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
          Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFCDD3D), Color(0xFF4CAF50)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: SvgPictureWidget(
            AppSvgIcons.icSplashLogo,
            color: Colors.white,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
