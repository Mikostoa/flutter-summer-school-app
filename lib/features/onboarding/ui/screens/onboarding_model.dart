import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Модель для экрана онбоардинга.
class OnboardingModel implements IOnboardingModel {
  static const String prefsKey = 'onboarding_completed';

  final _currentPageNotifier = ValueNotifier<int>(0);
  final _isLastPageNotifier = ValueNotifier<bool>(false);

  @override
  ValueListenable<int> get currentPageNotifier => _currentPageNotifier;

  @override
  int get currentPage => _currentPageNotifier.value;

  @override
  ValueListenable<bool> get isLastPageNotifier => _isLastPageNotifier;

  @override
  bool get isLastPage => _isLastPageNotifier.value;

  @override
  void setCurrentPage(int page) {
    _currentPageNotifier.value = page;
    _isLastPageNotifier.value = page == 2; // Предполагаем 3 страницы (0, 1, 2)
  }

  @override
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefsKey, true);
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(prefsKey) ?? false;
  }

  @override
  void dispose() {
    _currentPageNotifier.dispose();
    _isLastPageNotifier.dispose();
  }
}

/// Интерфейс модели онбоардинга.
abstract class IOnboardingModel {
  /// [ValueListenable] текущей страницы.
  ValueListenable<int> get currentPageNotifier;

  /// Текущая страница.
  int get currentPage;

  /// [ValueListenable] флага, указывающего, является ли текущая страница последней.
  ValueListenable<bool> get isLastPageNotifier;

  /// Флаг, указывающий, является ли текущая страница последней.
  bool get isLastPage;

  /// Установить текущую страницу.
  void setCurrentPage(int page);

  /// Отметить онбоардинг как завершенный.
  Future<void> completeOnboarding();

  /// Проверить, был ли онбоардинг завершен ранее.
  Future<bool> isOnboardingCompleted();

  /// Освободить ресурсы.
  void dispose();
}