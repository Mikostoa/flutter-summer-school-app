import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_model.dart';
import 'package:surf_places/features/tabs_screen/tabs_screen.dart'; // Импортируем TabsScreen

/// WM для экрана онбоардинга.
abstract class IOnboardingWM {
  /// Контроллер PageView.
  PageController get pageController;

  /// Текущая страница.
  int get currentPage;

  ValueListenable<int> get currentPageNotifier;

  /// [ValueListenable] флага, указывающего, является ли текущая страница последней.
  ValueListenable<bool> get isLastPageNotifier;

  /// Обработчик изменения страницы.
  void onPageChanged(int page);

  /// Обработчик нажатия кнопки "Пропустить".
  void onSkipPressed();

  /// Обработчик нажатия кнопки "Далее" / "На старт".
  void onNextPressed();

  /// Освободить ресурсы.
  void dispose();
}

/// Реализация WM для экрана онбоардинга.
class OnboardingWM implements IOnboardingWM {
  final IOnboardingModel _model;
  final BuildContext _context; // Сохраняем контекст для навигации

  @override
  final PageController pageController = PageController();

  OnboardingWM(this._model, this._context) {
    // Инициализируем начальное состояние
    _model.setCurrentPage(pageController.initialPage);
  }

  @override
  int get currentPage => _model.currentPage;

  @override
  ValueListenable<int> get currentPageNotifier => _model.currentPageNotifier;

  @override
  ValueListenable<bool> get isLastPageNotifier => _model.isLastPageNotifier;

  @override
  void onPageChanged(int page) {
    _model.setCurrentPage(page);
  }

  @override
  void onSkipPressed() {
    // Переходим к последней странице
    pageController.animateToPage(
      2, // Индекс последней страницы
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onNextPressed() async {
    if (_model.isLastPage) {
      // Завершаем онбоардинг
      await _model.completeOnboarding();
      // Переходим к основному экрану
      // Используем pushReplacement, чтобы не возвращаться к онбоардингу кнопкой "Назад"
      Navigator.of(_context).pushReplacement(
        MaterialPageRoute(builder: (context) => const TabsScreen()),
      );
    } else {
      // Переходим к следующей странице
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    _model.dispose();
  }
}
