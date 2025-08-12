import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/cubit/dasboard_cubit.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/router.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => DashboardCubit())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp.router(
          title: 'Recipe App',
          theme: ThemeData(
            fontFamily: 'Inter',
            scaffoldBackgroundColor: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              secondary: AppColors.secondary,
            ),
            useMaterial3: true,
            textTheme: TextTheme(
              headlineLarge: AppTypography.h1(context),
              headlineMedium: AppTypography.h2(context),
              headlineSmall: AppTypography.h3(context),
              bodyLarge: AppTypography.p1(context),
              bodyMedium: AppTypography.p2(context),
              bodySmall: AppTypography.small(context),
            ),
            appBarTheme: AppBarTheme(
              titleTextStyle: AppTypography.h1(context),
              elevation: 0,
            ),
          ),
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        );
      },
    );
  }
}
