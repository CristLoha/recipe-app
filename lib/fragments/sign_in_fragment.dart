import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/utils/app_assets.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_routes.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/app_textfield.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/size_helper.dart';

class SignInFragment extends StatelessWidget {
  const SignInFragment({super.key});

  @override
  Widget build(BuildContext context) {
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
          Gap(SizeHelper.fromFigmaHeight(72, context)),
          _buildAuthButton(context),
          Gap(SizeHelper.fromFigmaHeight(24, context)),
          _buildSignUp(context),
        ],
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
        const AppTextField(
          hintText: 'Password',
          prefixIcon: AppIcons.lock,
          isPassword: true,
        ),

        Gap(SizeHelper.fromFigmaHeight(24, context)),
        Align(
          alignment: Alignment.centerRight,
          child: Text('Forgot password?', style: AppTypography.p2(context)),
        ),
      ],
    );
  }

  Widget _buildAuthButton(BuildContext context) {
    return Column(
      children: [
        AppButton(label: "Login", onPressed: () {}, type: ButtonType.primary),
        Gap(SizeHelper.fromFigmaHeight(24, context)),
        Text(
          'Or continue with',
          style: AppTypography.p2(
            context,
          ).copyWith(color: AppColors.secondaryText),
        ),
        Gap(SizeHelper.fromFigmaHeight(24, context)),
        AppButton(
          label: "Continue with Google",
          onPressed: () {},
          type: ButtonType.google,
          icon: AppIcons.google,
        ),
      ],
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTypography.p2(
            context,
          ).copyWith(color: AppColors.secondaryText),
          children: [
            TextSpan(
              text: "Don't have an account? ",
              style: AppTypography.p2(context),
            ),
            TextSpan(
              text: 'Sign Up',
              style: AppTypography.h3(
                context,
              ).copyWith(color: AppColors.primary),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.go(AppRoutes.signUp);
                },
            ),
          ],
        ),
      ),
    );
  }
}
