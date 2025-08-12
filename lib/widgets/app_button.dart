import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_typography.dart';

enum ButtonType { primary, outlinePrimary, secondary, outlineSecondary, google }

enum ButtonSize { normal, small }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final String? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.normal,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Padding based on size
    final padding = switch (size) {
      ButtonSize.normal => const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 19,
      ),
      ButtonSize.small => const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 15,
      ),
    };

    // Background color based on type
    final backgroundColor = switch (type) {
      ButtonType.primary => AppColors.primary,
      ButtonType.outlinePrimary => Colors.transparent,
      ButtonType.secondary => AppColors.form,
      ButtonType.outlineSecondary => Colors.transparent,
      ButtonType.google => AppColors.google,
    };

    // Border based on type
    final borderSide = switch (type) {
      ButtonType.primary => BorderSide.none,
      ButtonType.outlinePrimary => BorderSide(color: AppColors.primary),
      ButtonType.secondary => BorderSide.none,
      ButtonType.outlineSecondary => BorderSide(color: AppColors.outline),
      ButtonType.google => BorderSide.none,
    };

    // Text color based on type
    final textColor = switch (type) {
      ButtonType.primary => Colors.white,
      ButtonType.outlinePrimary => AppColors.primary,
      ButtonType.secondary => AppColors.mainText,
      ButtonType.outlineSecondary => AppColors.secondaryText,
      ButtonType.google => Colors.white,
    };

    // Text style based on type.
    // We get the base style first.
    final baseTextStyle = AppTypography.buttonIcon(
      hasIcon: icon != null,
      color: textColor,
      context: context,
    );

    // For Google button, we override the font weight to bold.
    final textStyle = type == ButtonType.google
        ? baseTextStyle.copyWith(fontWeight: FontWeight.bold)
        : baseTextStyle;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: padding,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: borderSide,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SvgPicture.asset(
              icon!,
              width: 24,
              height: 24,
              // Ikon Google akan menggunakan warna aslinya,
              // ikon lain akan diwarnai sesuai textColor tombol.
              colorFilter: type == ButtonType.google
                  ? null
                  : ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
            const Gap(12),
          ],
          Text(label, style: textStyle),
        ],
      ),
    );
  }
}
