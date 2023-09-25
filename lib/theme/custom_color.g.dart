import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const deeporange = Color(0xFFFF5622);

CustomColors lightCustomColors = const CustomColors(
  sourceDeeporange: Color(0xFFFF5622),
  deeporange: Color(0xFFB02E00),
  onDeeporange: Color(0xFFFFFFFF),
  deeporangeContainer: Color(0xFFFFDBD1),
  onDeeporangeContainer: Color(0xFF3B0900),
);

CustomColors darkCustomColors = const CustomColors(
  sourceDeeporange: Color(0xFFFF5622),
  deeporange: Color(0xFFFFB5A0),
  onDeeporange: Color(0xFF601500),
  deeporangeContainer: Color(0xFF872100),
  onDeeporangeContainer: Color(0xFFFFDBD1),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceDeeporange,
    required this.deeporange,
    required this.onDeeporange,
    required this.deeporangeContainer,
    required this.onDeeporangeContainer,
  });

  final Color? sourceDeeporange;
  final Color? deeporange;
  final Color? onDeeporange;
  final Color? deeporangeContainer;
  final Color? onDeeporangeContainer;

  @override
  CustomColors copyWith({
    Color? sourceDeeporange,
    Color? deeporange,
    Color? onDeeporange,
    Color? deeporangeContainer,
    Color? onDeeporangeContainer,
  }) {
    return CustomColors(
      sourceDeeporange: sourceDeeporange ?? this.sourceDeeporange,
      deeporange: deeporange ?? this.deeporange,
      onDeeporange: onDeeporange ?? this.onDeeporange,
      deeporangeContainer: deeporangeContainer ?? this.deeporangeContainer,
      onDeeporangeContainer:
          onDeeporangeContainer ?? this.onDeeporangeContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceDeeporange: Color.lerp(sourceDeeporange, other.sourceDeeporange, t),
      deeporange: Color.lerp(deeporange, other.deeporange, t),
      onDeeporange: Color.lerp(onDeeporange, other.onDeeporange, t),
      deeporangeContainer:
          Color.lerp(deeporangeContainer, other.deeporangeContainer, t),
      onDeeporangeContainer:
          Color.lerp(onDeeporangeContainer, other.onDeeporangeContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceDeeporange]
  ///   * [CustomColors.deeporange]
  ///   * [CustomColors.onDeeporange]
  ///   * [CustomColors.deeporangeContainer]
  ///   * [CustomColors.onDeeporangeContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceDeeporange: sourceDeeporange!.harmonizeWith(dynamic.primary),
      deeporange: deeporange!.harmonizeWith(dynamic.primary),
      onDeeporange: onDeeporange!.harmonizeWith(dynamic.primary),
      deeporangeContainer: deeporangeContainer!.harmonizeWith(dynamic.primary),
      onDeeporangeContainer:
          onDeeporangeContainer!.harmonizeWith(dynamic.primary),
    );
  }
}
