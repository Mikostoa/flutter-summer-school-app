import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surf_places/api/service/api_client.dart';
import 'package:surf_places/core/data/database/database_helper.dart';
import 'package:surf_places/features/common/data/converters/place_converter.dart';
import 'package:surf_places/features/common/data/converters/place_type_converter.dart';
import 'package:surf_places/features/common/data/repositories/favorites_repository.dart';
import 'package:surf_places/features/common/domain/repositories/i_favorites_repository.dart';
import 'package:surf_places/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:surf_places/features/onboarding/domain/repositories/i_onboarding_repository.dart';
import 'package:surf_places/features/places/data/repositories/place_database_repository.dart';
import 'package:surf_places/features/places/data/repositories/places_repository.dart';
import 'package:surf_places/features/places/domain/reposiotries/i_places_repository.dart';
import 'package:surf_places/features/settings/ui/settings_model.dart';

/// Класс с зависимостями приложения.
abstract class AppDependencies {
  static List<SingleChildWidget> providers() {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = 'http://109.73.206.134:8888/api/'
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    final apiClient = ApiClient(dio);

    return [
      Provider<IOnboardingRepository>(
        create: (_) => const OnboardingRepository(),
      ),
      Provider<ApiClient>(create: (_) => apiClient),
      Provider<IFavoritesRepository>(create: (_) => FavoritesRepository()),
      Provider<ISettingsModel>(create: (_) => SettingsModel()),
      Provider<DatabaseHelper>(create: (_) => DatabaseHelper.instance),
      Provider<PlaceDatabaseRepository>(
        create:
            (context) =>
                PlaceDatabaseRepository(context.read<DatabaseHelper>()),
      ),
      Provider<IPlacesRepository>(
        create:
            (context) => PlacesRepository(
              apiClient: context.read<ApiClient>(),
              placeDtoToEntityConverter: PlaceDtoToEntityConverter(
                placeTypeConverter: PlaceTypeDtoToEntityConverter(),
              ),
              placeDatabaseRepository: context.read<PlaceDatabaseRepository>(),
            ),
      ),
    ];
  }
}
