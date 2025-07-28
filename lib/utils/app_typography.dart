import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/size_helper.dart';

class AppTypography {
  // Heder

  static TextStyle h1(BuildContext context) => GoogleFonts.inter(
    fontSize: SizeHelper.fromFigmaWidth(22, context),
    height: 32 / 22,
    fontWeight: FontWeight.bold,
    color: AppColors.mainText,
  );

  static TextStyle h2(BuildContext context) => GoogleFonts.inter(
    fontSize: SizeHelper.fromFigmaWidth(17, context),
    height: 27 / 17,
    fontWeight: FontWeight.bold,
    color: AppColors.mainText,
  );

  static TextStyle h3(BuildContext context) => GoogleFonts.inter(
        fontSize: SizeHelper.fromFigmaFontSize(15, context),
        height: 25 / 15,
        fontWeight: FontWeight.bold,
        color: AppColors.mainText,
      );

  // Body

  static TextStyle p1(BuildContext context) => GoogleFonts.inter(
        fontSize: SizeHelper.fromFigmaFontSize(17, context),
        height: 27 / 17,
        fontWeight: FontWeight.w500,
        color: AppColors.mainText,
      );

  static TextStyle p2(BuildContext context) => GoogleFonts.inter(
        fontSize: SizeHelper.fromFigmaFontSize(15, context),
        height: 25 / 15,
        fontWeight: FontWeight.w500,
        color: AppColors.mainText,
      );

  static TextStyle small(BuildContext context) => GoogleFonts.inter(
        fontSize: SizeHelper.fromFigmaFontSize(12, context),
        height: 15 / 12,
        fontWeight: FontWeight.w500,
        color: AppColors.mainText,
      );


  static TextStyle buttonIcon({
    required BuildContext context,
    required bool hasIcon,
    required Color color,
  }) {
    return GoogleFonts.inter(
      fontSize: SizeHelper.fromFigmaFontSize(hasIcon ? 15 : 16, context),
      fontWeight: hasIcon ? FontWeight.w500 : FontWeight.w700,
      color: color,
    );
  }
}
