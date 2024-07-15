final class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthSucessState extends AuthState {
  String message;
  AuthSucessState({required this.message});
}

final class AuthFailedState extends AuthState {
  String errorMessage;
  AuthFailedState({required this.errorMessage});
}

final class AuthLogoutState extends AuthState {
  String message;
  AuthLogoutState({required this.message});
}

final class AuthLoadingState extends AuthState {}
