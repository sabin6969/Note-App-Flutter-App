import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:note_app_flutter_mobile_app/constants/api_constant.dart';
import 'package:note_app_flutter_mobile_app/data/models/note_model.dart';
import 'package:note_app_flutter_mobile_app/exceptions/custom_exceptions.dart';

class NoteProvider {
  List<Note> notes = [];
  Future<List<Note>> getAllNotes({required String accessToken}) async {
    try {
      debugPrint("$baseUrl/$noteRoute/getAllNotes");
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
}
