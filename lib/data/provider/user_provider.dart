import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:note_app_flutter_mobile_app/constants/api_constant.dart';
import 'package:note_app_flutter_mobile_app/data/models/login_response_model.dart';
import 'package:note_app_flutter_mobile_app/exceptions/custom_exceptions.dart';

class UserProvider {
  Future<String> signupUser({
    required String email,
    required String password,
    required XFile imageFile,
    required String fullName,
  }) async {
    try {
      String fullUrl = "$baseUrl/$userRoute/createAccount";
      debugPrint(fullUrl);
      var postUri = Uri.parse(fullUrl);
      MultipartRequest request = MultipartRequest("POST", postUri);
      MultipartFile multipartFile = await MultipartFile.fromPath(
        "profileImage",
        File(imageFile.path).path,
      );
      request.files.add(multipartFile);
      request.fields["email"] = email;
      request.fields["password"] = password;
      request.fields["fullName"] = fullName;
      StreamedResponse streamedResponse = await request.send().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw ServerRequestTimeout();
        },
      );
      Response response = await Response.fromStream(streamedResponse);
      String message = getSignupResponse(response);
      return message;
    } catch (e) {
      return Future.error(e);
    }
  }

  String getSignupResponse(Response response) {
    switch (response.statusCode) {
      case 201:
        return jsonDecode(response.body)["message"];
      case 400:
        throw BadRequestException(
            errorMessage: jsonDecode(response.body)["message"]);
      case 409:
        throw ConflictError(errorMessage: jsonDecode(response.body)["message"]);
      case 500:
        throw InternalServerError(
            errorMessage: jsonDecode(response.body)["message"]);
      default:
        throw const CustomException(message: "Something went wrong");
    }
  }

  Future<LoginResponse> login(
      {required String email, required String password}) async {
    try {
      Response response = await post(
        Uri.parse(
          "$baseUrl/$userRoute/login",
        ),
        body: jsonEncode(
          {"email": email, "password": password},
        ),
        headers: {"Content-Type": "application/json"},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw ServerRequestTimeout();
        },
      );
      return getLoginResponse(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  LoginResponse getLoginResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return LoginResponse.fromJson(jsonDecode(response.body));
      case 400:
        throw BadRequestException(
            errorMessage: jsonDecode(response.body)["message"]);
      case 401:
        throw UnauthorizedError(
            errorMessage: jsonDecode(response.body)["message"]);
      case 404:
        throw NotFoundError(errorMessage: jsonDecode(response.body)["message"]);
      case 500:
        throw InternalServerError(
            errorMessage: jsonDecode(response.body)["message"]);
      default:
        throw const CustomException(message: "Something went wrong");
    }
  }
}
