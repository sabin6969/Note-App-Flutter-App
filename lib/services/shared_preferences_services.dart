import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  static const String _accessTokenKey = "accessToken";
  static SharedPreferences? _sharedPreferences;
  static Future<void> initSharedPreferenceService() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String? getAccessToken() {
    return _sharedPreferences?.getString(_accessTokenKey);
  }

  static void setAccessToken(String accessToken) async {
    await _sharedPreferences?.setString(_accessTokenKey, accessToken);
  }

  static void clearSharedPreferences() async {
    await _sharedPreferences?.clear();
  }
}
