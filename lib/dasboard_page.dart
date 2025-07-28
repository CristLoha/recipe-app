import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/cubit/dashboard_cubit.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_assets.dart';
import 'package:recipe_app/utils/app_routes.dart';
import 'package:recipe_app/utils/app_typography.dart';

class DasboardPage extends StatelessWidget {
  final Widget child;
  final String currentRouteName;
  const DasboardPage({
    super.key,
    required this.child,
    required this.currentRouteName,
  });

  @override
  Widget build(BuildContext context) {
    final Map<int, String> routeNames = {
      0: AppRoutes.home,
      1: AppRoutes.upload,
      2: AppRoutes.notification,
      3: AppRoutes.profile,
    };

    void onItemTapped(BuildContext context, int index) {
      final cubit = context.read<DashboardCubit>();
      cubit.changeIndex(index);
      context.go(routeNames[index]!);
    }

    return BlocProvider(
      create: (context) => DashboardCubit()..setIndex(currentRouteName),

      child: Scaffold(
        bottomNavigationBar: BlocBuilder<DashboardCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: AppTypography.small(context),
              selectedLabelStyle: AppTypography.small(context),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.secondaryText,
              onTap: (index) => onItemTapped(context, index),
              items: [
                _buildNavItem(currentIndex, AppIcons.home, 'Home', 0),
                _buildNavItem(currentIndex, AppIcons.upload, 'Upload', 1),
                _buildNavItem(
                  currentIndex,
                  AppIcons.notification,
                  'Notification',
                  2,
                ),
                _buildNavItem(currentIndex, AppIcons.profile, 'Profile', 3),
              ],
            );
          },
        ),
        body: child,
      ),
    );
  }
}

BottomNavigationBarItem _buildNavItem(
  int currentIndex,
  String iconPath,
  String label,
  int index,
) {
  final isSelected = index == currentIndex;
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 11),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.primary : AppColors.secondaryText,
          BlendMode.srcIn,
        ),
      ),
    ),
    label: label,
  );
}
