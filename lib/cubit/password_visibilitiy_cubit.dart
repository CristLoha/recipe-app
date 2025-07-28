import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordVisibilitiyCubit extends Cubit<bool> {
  PasswordVisibilitiyCubit() : super(true); // true = obscured (hidden)

  void toggle() => emit(!state);
}
