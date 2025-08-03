// lib/features/settings/data/settings_model.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISettingsModel {
  ValueListenable<bool> get isDarkThemeNotifier;
  bool get isDarkTheme;
  Future<void> toggleTheme();
  Future<void> resetOnboarding();
}

class SettingsModel implements ISettingsModel {
  static const String _themeKey = 'is_dark_theme';
  static const String _onboardingKey = 'onboarding_completed';

  final _isDarkThemeNotifier = ValueNotifier<bool>(false);

  SettingsModel() {
    _loadThemePreference();
  }

  @override
  ValueListenable<bool> get isDarkThemeNotifier => _isDarkThemeNotifier;

  @override
  bool get isDarkTheme => _isDarkThemeNotifier.value;

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkThemeNotifier.value = prefs.getBool(_themeKey) ?? false;
  }

  @override
  Future<void> toggleTheme() async {
    final newValue = !_isDarkThemeNotifier.value;
    _isDarkThemeNotifier.value = newValue;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, newValue);
  }

  @override
  Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, false);
  }

  void dispose() {
    _isDarkThemeNotifier.dispose();
  }
}