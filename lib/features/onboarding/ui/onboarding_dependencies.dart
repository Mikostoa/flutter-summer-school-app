import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_model.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_wm.dart';

/// Зависимости для экрана онбоардинга.
abstract class OnboardingDependencies {
  static List<SingleChildWidget> providers(BuildContext context) {
    return [
      Provider<IOnboardingModel>(
        create: (_) => OnboardingModel(),
      ),
      Provider<IOnboardingWM>(
        create: (context) => OnboardingWM(context.read<IOnboardingModel>(), context),
      ),
    ];
  }
}