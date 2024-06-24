final class SignupState {}

final class SignupInitialState extends SignupState {}

final class SignupSucessState extends SignupState {
  final String message;

  SignupSucessState({required this.message});
}

final class SignupFailedState extends SignupState {
  final String errorMessage;

  SignupFailedState({required this.errorMessage});
}

final class SignupLoadingState extends SignupState {}

final class SignupValidationError extends SignupState {
  final String message;
  SignupValidationError({required this.message});
}
