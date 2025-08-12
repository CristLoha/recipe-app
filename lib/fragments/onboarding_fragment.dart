import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/widgets/responsive_widget.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/utils/app_assets.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_routes.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/size_helper.dart';

class OnBoardingFragment extends StatelessWidget {
  static const double _buttonScaleFactor = 0.8;

  const OnBoardingFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        mobile: _buildMobileView(context),
        tablet: _buildTabletView(context),
        dekstop: _buildLandscapeLayout(context),
      ),
    );
  }

  Widget _buildImageReceipe(
    BuildContext context, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Container(
      width: width ?? SizeHelper.fromFigmaWidth(420, context),
      height: height ?? SizeHelper.fromFigmaHeight(420, context),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(AppImages.onboardingS),
          fit: fit,
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

  Widget _buildScaledContent(BuildContext context) {
    return Transform.scale(
      scale: _buttonScaleFactor,
      child: _buildContent(context),
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _buildMobilePortraitLayout(context);
        } else {
          return SingleChildScrollView(child: _buildLandscapeLayout(context));
        }
      },
    );
  }

  Widget _buildMobilePortraitLayout(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Gap(SizeHelper.safePadding(context).top),
        _buildImageReceipe(context),
        _buildContent(context),
      ],
    );
  }

  Widget _buildTabletView(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _buildTabletPortraitLayout(context);
        } else {
          return _buildLandscapeLayout(context);
        }
      },
    );
  }

  Widget _buildTabletPortraitLayout(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Gap(SizeHelper.safePadding(context).top),

        Center(
          child: _buildImageReceipe(
            context,
            width: SizeHelper.fromFigmaWidth(300, context),
            height: SizeHelper.fromFigmaHeight(450, context),
            fit: BoxFit.contain,
          ),
        ),
        _buildScaledContent(context),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Center(child: _buildImageReceipe(context))),

        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: _buildScaledContent(context),
            ),
          ),
        ),
      ],
    );
  }
}
