// lib/features/search/ui/search_dependencies.dart
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surf_places/api/service/api_client.dart';
import 'package:surf_places/features/common/data/converters/place_converter.dart';
import 'package:surf_places/features/common/data/converters/place_type_converter.dart';
import 'package:surf_places/features/search/data/repositories/search_repository.dart';
import 'package:surf_places/features/search/domain/repositories/i_search_repository.dart';
import 'package:surf_places/features/search/ui/screens/search_model.dart';
import 'package:surf_places/features/search/ui/screens/search_wm.dart';

abstract class SearchDependencies {
  static List<SingleChildWidget> providers() {
    return [
      Provider<ISearchRepository>(
        create: (context) => SearchRepository(
          apiClient: context.read<ApiClient>(),
          placeConverter: PlaceDtoToEntityConverter(
            placeTypeConverter: PlaceTypeDtoToEntityConverter(),
          ),
        ),
      ),
      Provider<ISearchModel>(
        create: (context) => SearchModel(context.read<ISearchRepository>()),
      ),
      Provider<ISearchWM>(
        create: (context) => SearchWM(context.read<ISearchModel>()),
      ),
    ];
  }
}