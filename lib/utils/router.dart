import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/dasboard_page.dart';
import 'package:recipe_app/fragments/home_fragment.dart';
import 'package:recipe_app/fragments/notification_fragment.dart';
import 'package:recipe_app/fragments/onboarding_fragment.dart';
import 'package:recipe_app/fragments/profile_fragment.dart';
import 'package:recipe_app/fragments/sign_in_fragment.dart';
import 'package:recipe_app/fragments/sign_up_fragment.dart';
import 'package:recipe_app/fragments/upload_fragment.dart';
import 'package:recipe_app/fragments/verification_code_fragment.dart';
import 'package:recipe_app/utils/app_routes.dart';

/// Observer untuk mengatur orientasi layar berdasarkan rute navigasi.
class OrientationRouteObserver extends NavigatorObserver {
  /// Daftar nama rute yang harus dikunci dalam mode potrait.
  static const _portraitLockedRoutes = [
    AppRoutes.signInName,
    AppRoutes.signUpName,
  ];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _setOrientationForRoute(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _setOrientationForRoute(previousRoute);
    }
  }

  void _setOrientationForRoute(Route<dynamic> route) {
    final routeName = route.settings.name;
    if (_portraitLockedRoutes.contains(routeName)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      // Izinkan semua orientasi untuk halaman lain.
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
  }
}

final GoRouter appRouter = GoRouter(
  observers: [OrientationRouteObserver()],
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      name: AppRoutes.onboardingName,
      builder: (context, state) => const OnBoardingFragment(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      name: AppRoutes.signInName,
      builder: (context, state) => const SignInFragment(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      name: AppRoutes.signUpName,
      builder: (context, state) => const SignUpFragment(),
    ),

    GoRoute(
      path: AppRoutes.verification,
      name: AppRoutes.verificationName,
      builder: (context, state) => const VerificationCodeFragment(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Kirim navigationShell yang dibuat otomatis oleh GoRouter ke DasboardPage
        return DashboardPage(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // Branch untuk Tab Home (index 0)
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.home,
              name: AppRoutes.homeName,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomeFragment()),
            ),
          ],
        ),

        // Branch untuk Tab Upload (index 1)
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.upload,
              name: AppRoutes.uploadName,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: UploadFragment()),
            ),
          ],
        ),

        // Branch untuk Tombol Scan (index 2)
        // Ini adalah branch "dummy" karena setiap branch butuh minimal 1 route.
        // Ini tidak akan pernah ditampilkan karena tombol Scan punya aksi `onPressed` sendiri.
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/scan', // Path dummy yang tidak akan pernah diakses
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SizedBox.shrink()),
            ),
          ],
        ),

        // Branch untuk Tab Notifikasi (index 3)
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.notification,
              name: AppRoutes.notificationName,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: NotificationFragment()),
            ),
          ],
        ),

        // Branch untuk Tab Profile (index 4)
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.profile,
              name: AppRoutes.profileName,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileFragment()),
            ),
          ],
        ),
      ],
    ),
  ],
);
