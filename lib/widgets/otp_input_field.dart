import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/size_helper.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isFocused;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final bool autofocus;
  const OtpInputField({
    super.key,
    this.controller,
    this.isFocused = false,
    this.onChanged,
    this.focusNode,
    this.onEditingComplete,
    this.textInputAction,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeHelper.fromFigmaWidth(72, context),
      height: SizeHelper.fromFigmaHeight(72, context),
      decoration: BoxDecoration(
        color: AppColors.form,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isFocused ? AppColors.primary : AppColors.outline,
          width: 1.5,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 1,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          textInputAction: textInputAction,
          style: AppTypography.textOtp(context),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            isCollapsed: true,
          ),
        ),
      ),
    );
  }
}
