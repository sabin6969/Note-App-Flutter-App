import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:note_app_flutter_mobile_app/constants/api_constant.dart';
import 'package:note_app_flutter_mobile_app/exceptions/custom_exceptions.dart';

class AuthProvider {
  Future<String> verifyAccesstoken({required String accessToken}) async {
    try {
      await InternetAddress.lookup(googleUrl);
      Response response = await post(
        Uri.parse(
          "$baseUrl/$authRoute/verifyAccesstoken",
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      return getResponseBody(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> logout({required String accessToken}) async {
    try {
      Response response = await post(
        Uri.parse("$baseUrl/$userRoute/logout"),
        headers: {"Authorization": "Bearer $accessToken"},
      );
      String message = getLogoutResponse(response: response);
      return message;
    } catch (e) {
      return Future.error(e);
    }
  }

  String getLogoutResponse({required Response response}) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body)["message"];
      case 401:
        throw const UnauthorizedError(
            errorMessage: "Unauthorized to perform this action.");
      default:
        throw const CustomException(message: "Something went wrong");
    }
  }

  String getResponseBody(Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body)["message"] ?? "";
      case 401:
        throw UnauthorizedError(
            errorMessage: jsonDecode(response.body)["message"] ?? "");
      case 500:
        throw InternalServerError(errorMessage: "Internal server error");
      default:
        throw const CustomException(message: "Something went wrong");
    }
  }
}
