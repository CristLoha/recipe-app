import 'package:go_router/go_router.dart';
import 'package:recipe_app/dasboard_page.dart';
import 'package:recipe_app/fragments/home_fragment.dart';
import 'package:recipe_app/fragments/notification_fragment.dart';
import 'package:recipe_app/fragments/onboarding_fragment.dart';
import 'package:recipe_app/fragments/profile_fragment.dart';
import 'package:recipe_app/fragments/sign_in_fragment.dart';
import 'package:recipe_app/fragments/sign_up_fragment.dart';
import 'package:recipe_app/fragments/upload_fragment.dart';
import 'package:recipe_app/utils/app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
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

    ShellRoute(
      builder: (context, state, child) =>
          DasboardPage(currentRouteName: state.name ?? '', child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: AppRoutes.homeName,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeFragment()),
        ),
        GoRoute(
          path: AppRoutes.upload,
          name: AppRoutes.uploadName,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: UploadFragment()),
        ),

        GoRoute(
          path: AppRoutes.notification,
          name: AppRoutes.notificationName,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: NotificationFragment()),
        ),

        GoRoute(
          path: AppRoutes.profile,
          name: AppRoutes.profileName,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfileFragment()),
        ),
      ],
    ),
  ],
);
