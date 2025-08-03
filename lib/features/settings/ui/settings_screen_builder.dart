// lib/features/settings/ui/settings_screen_builder.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_places/features/settings/model/settings_model.dart';
import 'package:surf_places/features/settings/ui/settings_screen.dart';
import 'package:surf_places/features/settings/viewmodel/settings_wm.dart';

class SettingsScreenBuilder extends StatelessWidget {
  const SettingsScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<ISettingsModel>(create: (_) => SettingsModel()),
        Provider<ISettingsWM>(create: (context) => SettingsWM(context.read<ISettingsModel>())),
      ],
      child: Builder(
        builder: (context) => SettingsScreen(wm: context.read<ISettingsWM>()),
      ),
    );
  }
}