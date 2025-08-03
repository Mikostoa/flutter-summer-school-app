import 'package:flutter/material.dart';
import 'package:surf_places/core/domain/entities/result/result.dart';
import 'package:surf_places/features/onboarding/domain/onboarding_state.dart';
import 'package:surf_places/features/onboarding/domain/repositories/i_onboarding_repository.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_screen_builder.dart';
import 'package:provider/provider.dart';
import 'package:surf_places/features/splash/ui/screens/splash_screen.dart';

/// Виджет, определяющий начальный экран приложения.
class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  late Future<OnboardingCheckState> _onboardingCheckFuture;

  @override
  void initState() {
    super.initState();
    _onboardingCheckFuture = _checkOnboarding();
  }

  Future<OnboardingCheckState> _checkOnboarding() async {
    final repository = context.read<IOnboardingRepository>();
    final result = await repository.isOnboardingCompleted();

    return switch (result) {
      ResultOk(:final data) => OnboardingCheckStateData(data),
      ResultFailed(:final error) => OnboardingCheckStateFailure(error),
    };
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OnboardingCheckState>(
      future: _onboardingCheckFuture,
      builder: (context, snapshot) {
        final state = snapshot.data;

        return switch (state) {
          OnboardingCheckStateLoading() => const _LoadingState(),
          OnboardingCheckStateFailure() => const OnboardingScreenBuilder(), 
          OnboardingCheckStateData(isOnboardingCompleted: final isCompleted) =>
            isCompleted ? const SplashScreen() : const OnboardingScreenBuilder(),
          _ => const _LoadingState(), 
        };
      },
    );
  }
}

/// Виджет состояния загрузки
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}