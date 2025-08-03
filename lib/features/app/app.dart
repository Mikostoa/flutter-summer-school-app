// lib/features/app/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_places/features/app/app_home.dart';
import 'package:surf_places/features/app/di/app_dependencies.dart';
import 'package:surf_places/features/settings/model/settings_model.dart';
import 'package:surf_places/uikit/themes/app_theme_data.dart';

class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...AppDependencies.providers()],
      child: Builder(
        builder: (context) {
          return ValueListenableBuilder<bool>(
            valueListenable: context.watch<ISettingsModel>().isDarkThemeNotifier,
            builder: (context, isDarkTheme, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppThemeData.lightTheme,
                darkTheme: AppThemeData.darkTheme,
                themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
                home: const AppHome(),
              );
            },
          );
        },
      ),
    );
  }
}