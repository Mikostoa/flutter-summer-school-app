import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_model.dart'; // Импортируем модель
import 'package:surf_places/features/onboarding/ui/screens/onboarding_screen_builder.dart';
import 'package:surf_places/features/tabs_screen/tabs_screen.dart';

/// Виджет, определяющий начальный экран приложения.
class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  late Future<bool> _onboardingCompletedFuture;

  @override
  void initState() {
    super.initState();
    // Инициируем проверку завершения онбоардинга
    _onboardingCompletedFuture = _checkOnboarding();
  }

  /// Проверяет, был ли онбоардинг завершен.
  Future<bool> _checkOnboarding() async {
    // Создаем временную модель для проверки
    // В идеале это должно делаться через отдельный сервис или репозиторий
    // Но для простоты создаем экземпляр модели здесь
    final model = OnboardingModel();
    final isCompleted = await model.isOnboardingCompleted();
    model.dispose(); // Не забываем освободить ресурсы
    return isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _onboardingCompletedFuture,
      builder: (context, snapshot) {
        // Пока проверяется состояние онбоардинга, показываем загрузку или пустой контейнер
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Можно показать SplashScreen или просто пустой контейнер
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
            // Обработка ошибки, если она возникла при проверке
            // Можно залогировать и показать экран по умолчанию или онбоардинг
            // Пока просто покажем онбоардинг
            return const OnboardingScreenBuilder();
        } else {
          // Если проверка завершена успешно
          final isCompleted = snapshot.data ?? false;
          if (isCompleted) {
            // Онбоардинг завершен, показываем основной экран
            return const TabsScreen();
          } else {
            // Онбоардинг не завершен, показываем онбоардинг
            return const OnboardingScreenBuilder();
          }
        }
      },
    );
  }
}