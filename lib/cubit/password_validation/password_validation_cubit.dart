import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/cubit/password_validation/password_validation_state.dart';


class PasswordValidationCubit extends Cubit<PasswordValidationState> {
  PasswordValidationCubit() : super(PasswordValidationInitial());

  void validatePassword(String password) {
    if (password.isEmpty) {
      emit(PasswordValidationInitial());
    } else {
      final hasSixCharacters = password.length >= 6;
      final hasNumber = password.contains(RegExp(r'[0-9]'));
      emit(
        PasswordValidationUpdated(
          hasSixCharacters: hasSixCharacters,
          hasNumber: hasNumber,
        ),
      );
    }
  }
}
