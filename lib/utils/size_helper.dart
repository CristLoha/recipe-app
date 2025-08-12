import 'package:flutter/material.dart';

class SizeHelper {
  SizeHelper._();

  // Ukuran desain dari Figma (dalam potrait)
  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  /// Ambil ukuran layar device
  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  /// Cek apakah mode landscape
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  /// Ambil rasio width yang menyesuaikan orientasi
  static double fromFigmaWidth(double value, BuildContext context) {
    final size = screenSize(context);
    final width = isLandscape(context) ? size.height : size.width;
    return width * (value / figmaWidth);
  }

  /// Ambil rasio height yang menyesuaikan orientasi
  static double fromFigmaHeight(double value, BuildContext context) {
    final size = screenSize(context);
    final height = isLandscape(context) ? size.width : size.height;
    return height * (value / figmaHeight);
  }

  /// Untuk font size (lebih aman pakai rasio lebar)
  static double fromFigmaFontSize(double fontSize, BuildContext context) =>
      fromFigmaWidth(fontSize, context);

  /// Radius atau icon size (gunakan rasio lebar)
  static double fromFigmaRadius(double value, BuildContext context) =>
      fromFigmaWidth(value, context);

  /// Padding safe area
  static EdgeInsets safePadding(BuildContext context) =>
      MediaQuery.of(context).padding;
}
