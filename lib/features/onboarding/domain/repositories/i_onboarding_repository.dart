import 'package:surf_places/core/domain/entities/result/request_operation.dart';

abstract interface class IOnboardingRepository {
  RequestOperation<bool> isOnboardingCompleted();
  RequestOperation<void> completeOnboarding();
}