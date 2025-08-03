import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_places/core/data/repositories/base_repository.dart';
import 'package:surf_places/core/domain/entities/result/request_operation.dart';
import 'package:surf_places/features/onboarding/domain/repositories/i_onboarding_repository.dart';
import 'package:surf_places/features/onboarding/ui/screens/onboarding_model.dart';

final class OnboardingRepository extends BaseRepository implements IOnboardingRepository {
  const OnboardingRepository();

  @override
  RequestOperation<bool> isOnboardingCompleted() {
    return makeApiCall(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(OnboardingModel.prefsKey) ?? false;
    });
  }

  @override
  RequestOperation<void> completeOnboarding() {
    return makeApiCall(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(OnboardingModel.prefsKey, true);
    });
  }
}