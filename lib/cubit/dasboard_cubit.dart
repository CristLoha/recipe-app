import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/utils/app_routes.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  void setIndex(String routeName) {
    // Using if-else with `startsWith` to correctly handle sub-routes
    // (e.g., '/profile/edit' should keep the 'Profile' tab active).
    if (routeName.startsWith(AppRoutes.profile)) {
      emit(3);
    } else if (routeName.startsWith(AppRoutes.notification)) {
      emit(2);
    } else if (routeName.startsWith(AppRoutes.upload)) {
      emit(1);
    } else if (routeName.startsWith(AppRoutes.home)) {
      emit(0);
    } else {
      emit(0); // Default to home
    }
  }

  void changeIndex(int index) => emit(index);
}
