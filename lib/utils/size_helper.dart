import 'package:flutter/material.dart';

class SizeHelper {
  // Private constructor to prevent instantiation of this utility class.
  SizeHelper._();

  // Ukuran desain di Figma (misal: iPhone 11 Pro / X)
  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  /// Ambil ukuran layar device
  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  /// Skala dari Figma width ke device width
  static double fromFigmaWidth(double value, BuildContext context) =>
      screenSize(context).width * (value / figmaWidth);

  /// Skala dari Figma height ke device height
  static double fromFigmaHeight(double value, BuildContext context) =>
      screenSize(context).height * (value / figmaHeight);

  /// Skala untuk font size.
  /// Umumnya, penskalaan berdasarkan lebar (width) lebih disukai untuk font
  /// agar tata letak teks tidak rusak pada perangkat yang sangat tinggi atau pendek.
  static double fromFigmaFontSize(double fontSize, BuildContext context) =>
      fromFigmaWidth(fontSize, context);

  /// Skala untuk nilai yang seharusnya seragam (seperti radius atau ukuran ikon).
  /// Menggunakan skala lebar sebagai default untuk konsistensi visual.
  static double fromFigmaRadius(double value, BuildContext context) =>
      fromFigmaWidth(value, context);

  /// Ambil padding safe area (top, bottom, dll)
  static EdgeInsets safePadding(BuildContext context) =>
      MediaQuery.of(context).padding;
}
