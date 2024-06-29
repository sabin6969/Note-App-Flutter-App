import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:note_app_flutter_mobile_app/constants/api_constant.dart';
import 'package:note_app_flutter_mobile_app/data/models/note_model.dart';
import 'package:note_app_flutter_mobile_app/exceptions/custom_exceptions.dart';

class NoteProvider {
  List<Note> notes = [];
  Future<List<Note>> getAllNotes({required String accessToken}) async {
    try {
      await InternetAddress.lookup(googleUrl);
      Response response = await get(
        Uri.parse(
          "$baseUrl/$noteRoute/getAllNotes",
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw ServerRequestTimeout();
        },
      );

      return getResponsedata(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  List<Note> getResponsedata(Response response) {
    switch (response.statusCode) {
      case 200:
        notes.clear();
        var fetchedNotes = jsonDecode(response.body)["data"] ?? [];
        for (Map<String, dynamic> i in fetchedNotes) {
          notes.add(Note.fromJson(i));
        }
        return notes;
      case 401:
        throw UnauthorizedError(
            errorMessage: jsonDecode(response.body)["message"] ?? "");
      case 500:
        throw InternalServerError(
            errorMessage: jsonDecode(response.body)["message"] ??
                "Internal server error!");
      default:
        throw const CustomException(message: "Something went wrong");
    }
  }

  Future<String> createNote(
      {required String accessToken,
      required String noteTitle,
      required String noteDescription}) async {
    try {
      Response response = await post(
        Uri.parse("$baseUrl/$noteRoute/createNote"),
        headers: {
          "Authorization": "Bearer $accessToken",
          "content-type": "application/json",
        },
        body: jsonEncode(
          {
            "noteTitle": noteTitle,
            "noteDescription": noteDescription,
          },
        ),
      );
      return getJsonResponse(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> deleteNote(
      {required String accessToken, required String noteId}) async {
    try {
      Response response = await delete(
        Uri.parse(
          "$baseUrl/$noteRoute/deleteNote/$noteId",
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      String message = getJsonResponse(response);
      return message;
    } catch (e) {
      return Future.error(e);
    }
  }

  String getJsonResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body)["message"] ?? "";
      case 201:
        return jsonDecode(response.body)["message"] ?? "";
      case 400:
        throw BadRequestException(
            errorMessage: jsonDecode(response.body)["message"] ?? "");
      case 401:
        throw UnauthorizedError(
            errorMessage: jsonDecode(response.body)["message"] ??
                "Unauthorized access login again");
      case 500:
        throw InternalServerError(
          errorMessage: "Internal server error",
        );
      default:
        throw const CustomException(message: "Something went wrong");
    }
  }

  Future<String> updateNote(
      {required String noteId,
      required String noteTitle,
      required String noteDescription,
      required String accessToken}) async {
    Response response = await patch(
      Uri.parse("$baseUrl/$noteRoute/updateNote/$noteId"),
      headers: {
        "Authorization": "Bearer $accessToken",
        "content-type": "application/json",
      },
      body: jsonEncode({
        "noteTitle": noteTitle,
        "noteDescription": noteDescription,
      }),
    );
    String message = getJsonResponse(response);
    return message;
  }
}
