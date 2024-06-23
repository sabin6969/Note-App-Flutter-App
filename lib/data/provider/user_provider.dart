import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:note_app_flutter_mobile_app/constants/api_constant.dart';
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
      String message = getResponseBody(response);
      return message;
    } catch (e) {
      return Future.error(e);
    }
  }

  getResponseBody(Response response) {
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
}
