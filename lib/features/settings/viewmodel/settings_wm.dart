// lib/features/settings/ui/settings_wm.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_screen_builder.dart';
import 'package:surf_places/features/settings/model/settings_model.dart';

abstract class ISettingsWM {
  ValueListenable<bool> get isDarkThemeNotifier;
  void toggleTheme();
  void resetOnboarding(BuildContext context);
}

class SettingsWM implements ISettingsWM {
  final ISettingsModel _model;

  SettingsWM(this._model);

  @override
  ValueListenable<bool> get isDarkThemeNotifier => _model.isDarkThemeNotifier;

  @override
  void toggleTheme() {
    _model.toggleTheme();
  }

  @override
  void resetOnboarding(BuildContext context) {
    // _model.resetOnboarding().then((_) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Onboarding has been reset')),
    //   );
    // });
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OnboardingScreenBuilder()));
  }
}