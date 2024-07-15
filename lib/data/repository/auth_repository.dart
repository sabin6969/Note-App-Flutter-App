import 'package:note_app_flutter_mobile_app/data/provider/auth_provider.dart';

abstract class KAuthRepository {
  Future<String> verifyAccesstoken({required String accessToken});
  Future<String> logout({required String accessToken});
}

class AuthRepository implements KAuthRepository {
  final AuthProvider authProvider;
  const AuthRepository({required this.authProvider});
  @override
  Future<String> verifyAccesstoken({required String accessToken}) async {
    return await authProvider.verifyAccesstoken(accessToken: accessToken);
  }

  @override
  Future<String> logout({required String accessToken}) async {
    return await authProvider.logout(accessToken: accessToken);
  }
}
