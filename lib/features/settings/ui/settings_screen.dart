import 'package:flutter/material.dart';
import 'package:surf_places/assets/images/app_svg_icons.dart';
import 'package:surf_places/assets/strings/app_strings.dart';
import 'package:surf_places/features/settings/ui/settings_wm.dart';
import 'package:surf_places/uikit/images/svg_picture_widget.dart';
import 'package:surf_places/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_places/uikit/themes/colors/app_colors.dart';
import 'package:surf_places/uikit/themes/text/app_text_theme.dart';

class SettingsScreen extends StatelessWidget {
  final ISettingsWM wm;

  const SettingsScreen({required this.wm, super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Scaffold(
      appBar: AppBar(title: Center(child: const Text(AppStrings.settingsScreenTitle))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),

          ValueListenableBuilder<bool>(
            valueListenable: wm.isDarkThemeNotifier,
            builder: (context, isDarkTheme, _) {
              return SwitchListTile(
                title: Text(
                  AppStrings.settingsThemeToggle,
                  style: textTheme.text.copyWith(
                    color: colorTheme.textSecondary,
                  ),
                ),
                value: isDarkTheme,
                onChanged: (_) => wm.toggleTheme(),
                activeColor: colorTheme.accent,
              );
            },
          ),
          const SizedBox(height: 8),

          ListTile(
            title: Text(
              AppStrings.settingsResetOnboarding,
            ),
            trailing: SvgPictureWidget(
              AppSvgIcons.icInfo,
              color: AppColors.colorBlackGreen,
            ),
            onTap: () => wm.resetOnboarding(context),
          ),
        ],
      ),
    );
  }
}
