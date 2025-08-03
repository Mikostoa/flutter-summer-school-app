import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_places/uikit/themes/colors/app_color_theme.dart';

/// {@template svg_picture_widget.class}
/// Компонент для отображения SVG изображения.
/// {@endtemplate}
class SvgPictureWidget extends StatelessWidget {
  /// Путь до ассета с svg.
  final String svgPath;

  /// Цвет иконки.
  final Color? color;

  /// Ширина иконки.
  final double? width;

  /// Высота иконки.
  final double? height;

  /// Фит иконки.
  final BoxFit fit;

  /// {@macro svg_picture_widget.class}
  const SvgPictureWidget(
    this.svgPath, {
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);

    final color = this.color;

    final iconColor = color ?? colorTheme.textPrimary;

    final colorFilter = ColorFilter.mode(iconColor, BlendMode.srcIn);

    return SvgPicture.asset(
      svgPath,
      width: width,
      height: height,
      fit: fit,
      colorFilter: colorFilter,
    );
  }
}
