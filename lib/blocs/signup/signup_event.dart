import 'package:image_picker/image_picker.dart';

final class SignupEvent {}

final class SignupButtonPressedEvent extends SignupEvent {
  final String fullName;
  final String password;
  final String email;
  final XFile? imageFile;

  SignupButtonPressedEvent({
    required this.fullName,
    required this.password,
    required this.email,
    required this.imageFile,
  });
}
