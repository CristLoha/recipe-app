import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/cubit/password_validation/password_validation_cubit.dart';
import 'package:recipe_app/cubit/password_validation/password_validation_state.dart';
import 'package:recipe_app/utils/app_assets.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/size_helper.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/app_textfield.dart';

class SignUpFragment extends StatelessWidget {
  const SignUpFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordValidationCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: ListView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top:
                    SizeHelper.safePadding(context).top +
                    SizeHelper.fromFigmaWidth(107, context),
                bottom: SizeHelper.safePadding(context).bottom + 41,
              ),
              children: [
                _buildHeader(context),
                Gap(SizeHelper.fromFigmaHeight(32, context)),
                _buildForm(context),
                BlocBuilder<PasswordValidationCubit, PasswordValidationState>(
                  builder: (context, state) {
                    // Saat validasi muncul, kurangi gap agar posisi tombol stabil.
                    // Saat validasi hilang, kembalikan gap ke 72.
                    final gapHeight = (state is PasswordValidationUpdated)
                        ? 24.0
                        : 72.0;
                    return Gap(SizeHelper.fromFigmaHeight(gapHeight, context));
                  },
                ),
                _buildAuthButton(context),
                Gap(SizeHelper.fromFigmaHeight(24, context)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text('Welcome Back!', style: AppTypography.h1(context)),
        const Gap(8),
        Text(
          'Please enter your account here',
          style: AppTypography.p2(
            context,
          ).copyWith(color: AppColors.secondaryText),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppTextField(
          hintText: 'Email or phone number',
          prefixIcon: AppIcons.message,
        ),
        Gap(SizeHelper.fromFigmaHeight(16, context)),
        AppTextField(
          onChanged: (password) => context
              .read<PasswordValidationCubit>()
              .validatePassword(password),
          hintText: 'Password',
          prefixIcon: AppIcons.lock,
          isPassword: true,
        ),
        Gap(SizeHelper.fromFigmaHeight(24, context)),
        _buildPasswordValidation(context),
      ],
    );
  }

  Widget _buildPasswordValidation(BuildContext context) {
    return BlocBuilder<PasswordValidationCubit, PasswordValidationState>(
      builder: (context, state) {
        if (state is PasswordValidationUpdated) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Password must contain:',
                style: AppTypography.p1(
                  context,
                ).copyWith(color: AppColors.passwordCheckTitle),
              ),
              const Gap(16),
              _buildValidationRow(
                context,
                'Atleast 6 characters',
                state.hasSixCharacters,
              ),
              const Gap(16),
              _buildValidationRow(
                context,
                'Contains a number',
                state.hasNumber,
              ),
            ],
          );
        }
        // Return an empty widget if the state is initial
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildValidationRow(BuildContext context, String text, bool isValid) {
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.check,
          colorFilter: ColorFilter.mode(
            isValid ? AppColors.primary : AppColors.secondaryText,
            BlendMode.srcIn,
          ),
        ),

        const Gap(8),
        Text(
          text,
          style: AppTypography.p2(context).copyWith(
            color: isValid ? AppColors.mainText : AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthButton(BuildContext context) {
    return Column(
      children: [
        AppButton(label: "Sign Up", onPressed: () {}, type: ButtonType.primary),
      ],
    );
  }
}
