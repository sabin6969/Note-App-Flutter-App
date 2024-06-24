final class LoginEvent {}

final class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;
  LoginButtonPressedEvent({required this.email, required this.password});
}
