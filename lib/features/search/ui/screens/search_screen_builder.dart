import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_places/features/search/ui/search_dependencies.dart';
import 'package:surf_places/features/search/ui/screens/search_screen.dart';
import 'package:surf_places/features/search/ui/screens/search_wm.dart';

class SearchScreenBuilder extends StatelessWidget {
  const SearchScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: SearchDependencies.providers(),
      child: Builder(
        builder: (context) => SearchScreen(wm: context.read<ISearchWM>()),
      ),
    );
  }
}