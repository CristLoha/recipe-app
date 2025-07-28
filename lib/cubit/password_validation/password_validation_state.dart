
import 'package:equatable/equatable.dart';

abstract class PasswordValidationState extends Equatable {
  const PasswordValidationState();

  @override
  List<Object> get props => [];
}

class PasswordValidationInitial extends PasswordValidationState {}

class PasswordValidationUpdated extends PasswordValidationState {
  final bool hasSixCharacters;
  final bool hasNumber;

  const PasswordValidationUpdated({
    required this.hasSixCharacters,
    required this.hasNumber,
  });

  @override
  List<Object> get props => [hasSixCharacters, hasNumber];
}
