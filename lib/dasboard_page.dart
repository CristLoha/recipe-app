import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_app/cubit/dasboard_cubit.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_assets.dart';
import 'package:recipe_app/utils/app_typography.dart';

class DashboardPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardPage({super.key, required this.navigationShell});

  void _onItemTapped(BuildContext context, int tappedIndex) {
    if (tappedIndex == 2) {
      return;
    }

    final int shellIndex = tappedIndex > 2 ? tappedIndex - 1 : tappedIndex;

    context.read<DashboardCubit>().changeIndex(shellIndex);
    navigationShell.goBranch(
      shellIndex,
      initialLocation: shellIndex == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Fitur Scan akan segera hadir! ✨'),
              backgroundColor: AppColors.primary,

              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        elevation: 4.0,
        child: SvgPicture.asset(
          AppIcons.scan,
          width: 28,
          height: 28,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: navigationShell,

      bottomNavigationBar: BlocBuilder<DashboardCubit, int>(
        builder: (context, currentShellIndex) {
          int bottomBarIndex = currentShellIndex;
          if (currentShellIndex >= 2) {
            bottomBarIndex = currentShellIndex + 1;
          }

          return BottomNavigationBar(
            currentIndex: bottomBarIndex,

            onTap: (index) => _onItemTapped(context, index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.secondaryText.withOpacity(0.6),
            selectedLabelStyle: AppTypography.small(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
            unselectedLabelStyle: AppTypography.small(
              context,
            ).copyWith(fontWeight: FontWeight.w400),

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.home,
                  colorFilter: ColorFilter.mode(
                    AppColors.secondaryText.withOpacity(0.6),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.home,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.upload,
                  colorFilter: ColorFilter.mode(
                    AppColors.secondaryText.withOpacity(0.6),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.upload,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Upload',
              ),

              const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.notification,
                  colorFilter: ColorFilter.mode(
                    AppColors.secondaryText.withOpacity(0.6),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.notification,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.profile,
                  colorFilter: ColorFilter.mode(
                    AppColors.secondaryText.withOpacity(0.6),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.profile,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
