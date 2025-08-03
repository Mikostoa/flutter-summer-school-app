import 'package:flutter/foundation.dart';

@immutable
sealed class OnboardingCheckState {
  const OnboardingCheckState();
}

/// Состояние загрузки
final class OnboardingCheckStateLoading extends OnboardingCheckState {
  const OnboardingCheckStateLoading();
}

/// Состояние ошибки
final class OnboardingCheckStateFailure extends OnboardingCheckState {
  final Object error;

  const OnboardingCheckStateFailure(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingCheckStateFailure &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

/// Состояние с данными
final class OnboardingCheckStateData extends OnboardingCheckState {
  final bool isOnboardingCompleted;

  const OnboardingCheckStateData(this.isOnboardingCompleted);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingCheckStateData &&
          runtimeType == other.runtimeType &&
          isOnboardingCompleted == other.isOnboardingCompleted;

  @override
  int get hashCode => isOnboardingCompleted.hashCode;
}