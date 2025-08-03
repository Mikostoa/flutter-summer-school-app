import 'package:flutter/material.dart';
import 'package:surf_places/uikit/images/svg_picture_widget.dart';
import 'package:surf_places/uikit/themes/colors/app_color_theme.dart';

/// {@template icon_action_button.class}
/// Кнопки действий для карточек поверх картинки.
/// {@endtemplate}
class IconActionButton extends StatelessWidget {
  final String svgPath;
  final double size;
  final Color? color; // Сделайте color необязательным, если хотите использовать цвет темы по умолчанию
  final VoidCallback? onPressed;

  /// {@macro icon_action_button.class}
  const IconActionButton({
    required this.svgPath,
    this.color, // Принимаем опциональный цвет
    this.onPressed,
    this.size = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    // Определяем цвет иконки: либо переданный, либо из темы (например, colorTheme.icon)
    final iconColor =
        color ?? colorTheme.icon; // Используйте нужное свойство темы
    return SizedBox(
      width: 32,
      height: 32,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.all(4),
          shape: const CircleBorder(),
        ),
        child: SvgPictureWidget(
          svgPath,
          color: iconColor,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
