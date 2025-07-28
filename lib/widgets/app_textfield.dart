import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:recipe_app/cubit/password_visibilitiy_cubit.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/size_helper.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String prefixIcon;
  final Function(String)? onChanged;
  final bool isPassword;
  final bool isValid;

  const AppTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.onChanged,
    this.isPassword = false,
    this.isValid = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;
  late final ValueNotifier<bool> _isIconPrimaryNotifier;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isIconPrimaryNotifier = ValueNotifier<bool>(
      widget.controller?.text.isNotEmpty ?? false,
    );

    _focusNode.addListener(_updateIconState);
    widget.controller?.addListener(_updateIconState);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_updateIconState);
    widget.controller?.removeListener(_updateIconState);
    _focusNode.dispose();
    _isIconPrimaryNotifier.dispose();
    super.dispose();
  }

  void _updateIconState() {
    final bool hasText = widget.controller?.text.isNotEmpty ?? false;
    final bool isFocused = _focusNode.hasFocus;
    _isIconPrimaryNotifier.value = isFocused || hasText;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isIconPrimaryNotifier,
      builder: (context, isIconPrimary, child) {
        if (widget.isPassword) {
          return BlocProvider(
            create: (context) => PasswordVisibilitiyCubit(),
            child: BlocBuilder<PasswordVisibilitiyCubit, bool>(
              builder: (context, obscure) {
                return _buildTextField(
                  isIconPrimary: isIconPrimary,
                  obscure: obscure,
                  onSuffixPressed: () {
                    context.read<PasswordVisibilitiyCubit>().toggle();
                  },
                );
              },
            ),
          );
        }
        return _buildTextField(isIconPrimary: isIconPrimary);
      },
    );
  }

  TextField _buildTextField({
    required bool isIconPrimary,
    bool obscure = false,
    VoidCallback? onSuffixPressed,
  }) {
    final bool hasText = widget.controller?.text.isNotEmpty ?? false;
    return TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.isPassword ? obscure : false,
      style: AppTypography.p2(context),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: SizeHelper.fromFigmaHeight(19, context),
        ),
        hintText: widget.hintText,
        hintStyle: AppTypography.p2(
          context,
        ).copyWith(color: AppColors.secondaryText),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: SizeHelper.fromFigmaHeight(24, context),
            right: SizeHelper.fromFigmaHeight(3, context),
          ),
          child: SvgPicture.asset(
            widget.prefixIcon,
            colorFilter: ColorFilter.mode(
              isIconPrimary ? AppColors.primary : AppColors.mainText,
              BlendMode.srcIn,
            ),
          ),
        ),

        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.secondaryText,
                ),
                onPressed: onSuffixPressed,
              )
            : widget.isValid && hasText
            ? Icon(Icons.check_circle, color: AppColors.primary)
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: AppColors.outline, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
