import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/utils/app_assets.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_routes.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/size_helper.dart';

class OnBoardingFragment extends StatelessWidget {
  const OnBoardingFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Menambahkan padding atas dari safe area + 12px dari Figma
          // agar posisi gambar sesuai desain di semua perangkat.
          Gap(
            SizeHelper.safePadding(context).top +
                SizeHelper.fromFigmaHeight(12, context),
          ),
          _buildImageReceipe(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildImageReceipe(BuildContext context) {
    return Container(
      width: SizeHelper.fromFigmaWidth(420, context),
      height: SizeHelper.fromFigmaHeight(420, context),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.onboardingS),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeHelper.fromFigmaHeight(48, context),
        left: 24,
        right: 24,
        // Penggunaan safePadding di sini sudah sangat tepat untuk
        // memastikan tombol tidak terhalang UI sistem.
        bottom: SizeHelper.safePadding(context).bottom + 24,
      ),
      child: Column(
        children: [
          Text('Start Cooking', style: AppTypography.h1(context)),
          Gap(SizeHelper.fromFigmaHeight(16, context)),
          Text(
            "Let's join our community\nto cook better food!",
            textAlign: TextAlign.center,
            style: AppTypography.p1(
              context,
            ).copyWith(color: AppColors.secondaryText),
          ),
          Gap(SizeHelper.fromFigmaHeight(72, context)),
          AppButton(
            label: "Get Started",
            onPressed: () => GoRouter.of(context).go(AppRoutes.signIn),
            type: ButtonType.primary,
          ),
        ],
      ),
    );
  }
}
