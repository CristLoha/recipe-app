import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/size_helper.dart';

enum TextFieldType { normal, search }

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String prefixIcon;
  final Function(String)? onChanged;
  final TextFieldType type;
  final bool isPassword;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.onChanged,
    this.type = TextFieldType.normal,
    this.isPassword = false,
    this.keyboardType,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;
  late final ValueNotifier<bool> _isIconPrimaryNotifier;
  bool _obscureText = true;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isIconPrimaryNotifier = ValueNotifier<bool>(
      widget.controller?.text.isNotEmpty ?? false,
    );

    _isValid = _validate(widget.controller?.text ?? '');
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

  bool _validate(String value) {
    if (value.isEmpty) return false;

    switch (widget.keyboardType) {
      case TextInputType.emailAddress:
        final emailRegex = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        );
        return emailRegex.hasMatch(value);
      default:
        // Untuk tipe lain, anggap valid jika tidak kosong
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isIconPrimaryNotifier,
      builder: (context, isIconPrimary, child) {
        if (widget.isPassword) {
          return _buildTextField(
            isIconPrimary: isIconPrimary,
            obscure: _obscureText,
            onSuffixPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
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

    final fillColor = switch (widget.type) {
      TextFieldType.normal => Colors.white,
      TextFieldType.search => AppColors.form,
    };

    final border = switch (widget.type) {
      TextFieldType.normal => OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(color: AppColors.outline, width: 2),
      ),
      TextFieldType.search => OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide.none,
      ),
    };

    return TextField(
      keyboardType: widget.keyboardType,
      onChanged: (value) {
        final newValidity = _validate(value);
        if (_isValid != newValidity) {
          setState(() {
            _isValid = newValidity;
          });
        }
        // Panggil callback eksternal jika ada
        widget.onChanged?.call(value);
      },
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
        fillColor: fillColor,
        filled: true,
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: SizeHelper.fromFigmaHeight(24, context),
            right: SizeHelper.fromFigmaHeight(3, context),
          ),
          child: SvgPicture.asset(
            widget.prefixIcon,
            colorFilter: ColorFilter.mode(
              isIconPrimary && widget.type != TextFieldType.search
                  ? AppColors.primary
                  : AppColors.mainText,
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
            : _isValid && hasText
            ? Icon(Icons.check_circle, color: AppColors.primary)
            : null,
        border: border,
        enabledBorder: border,
        focusedBorder: widget.type == TextFieldType.normal
            ? border.copyWith(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              )
            : border,
      ),
    );
  }
}
