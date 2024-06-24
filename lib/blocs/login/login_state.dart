import 'package:note_app_flutter_mobile_app/data/models/login_response_model.dart';

final class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSucessState extends LoginState {
  final LoginResponse loginResponse;
  LoginSucessState({required this.loginResponse});
}

final class LoginValidationErrorState extends LoginState {
  final String message;
  LoginValidationErrorState({required this.message});
}

final class LoginFailedState extends LoginState {
  final String message;
  LoginFailedState({required this.message});
}
