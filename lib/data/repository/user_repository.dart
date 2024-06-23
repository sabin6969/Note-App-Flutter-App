import 'package:image_picker/image_picker.dart';
import 'package:note_app_flutter_mobile_app/data/provider/user_provider.dart';

abstract class KUserRepository {
  Future<String> signupUser({
    required String email,
    required String password,
    required XFile imageFile,
    required String fullName,
  });
}

class UserRepository extends KUserRepository {
  final UserProvider userProvider;
  UserRepository({required this.userProvider});
  @override
  Future<String> signupUser(
      {required String email,
      required String password,
      required XFile imageFile,
      required String fullName}) async {
    return await userProvider.signupUser(
      email: email,
      password: password,
      imageFile: imageFile,
      fullName: fullName,
    );
  }
}
