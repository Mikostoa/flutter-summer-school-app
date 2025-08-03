import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_places/features/onboarding/ui/onboarding_dependencies.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_screen.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_wm.dart';

/// Билдер для экрана онбоардинга.
class OnboardingScreenBuilder extends StatelessWidget {
  const OnboardingScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: OnboardingDependencies.providers(context), // Передаем context
      child: Builder(
        builder: (context) => OnboardingScreen(wm: context.read<IOnboardingWM>()),
      ),
    );
  }
}