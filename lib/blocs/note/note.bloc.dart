import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note_state.dart';
import 'package:note_app_flutter_mobile_app/data/models/note_model.dart';
import 'package:note_app_flutter_mobile_app/data/repository/note_repository.dart';
import 'package:note_app_flutter_mobile_app/exceptions/custom_exceptions.dart';
import 'package:note_app_flutter_mobile_app/services/shared_preferences_services.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;
  NoteBloc({required this.noteRepository}) : super(NoteInitialState()) {
    on<LoadNoteEvent>(handleLoadNoteEvent);
    on<AddNoteEvent>(handleAddNoteEvent);
  }

  void handleLoadNoteEvent(LoadNoteEvent event, Emitter<NoteState> emit) async {
    try {
      debugPrint("Loading!!!");
      emit(NoteLoadingState());
      String accessToken = SharedPreferenceServices.getAccessToken() ?? "";
      List<Note> notes =
          await noteRepository.getAllNotes(accessToken: accessToken);
      emit(NoteLoadedState(notes: notes));
      debugPrint("Loadedd!!!");
    } on UnauthorizedError catch (e) {
      debugPrint("Unauthorized error!!");
      emit(NoteLoadingFailedState(errorMessage: e.message));
    } on CustomException catch (e) {
      debugPrint("Custom error");
      emit(NoteLoadingFailedState(errorMessage: e.message));
    } on SocketException {
      emit(NoteLoadingFailedState(
        errorMessage: "Please make sure that you have internet connection",
      ));
    } catch (e) {
      debugPrint("Something went wrong!!");
      emit(NoteLoadingFailedState(
          errorMessage: "Something went wrong while fetching notes"));
    }
  }

  void handleAddNoteEvent(AddNoteEvent event, Emitter<NoteState> emit) async {
    if (event.noteDescription.isEmpty || event.noteTitle.isEmpty) {
      emit(
        NoteValidationFailedState(
          message: "Both title and description is required",
        ),
      );
    } else {
      try {
        emit(NoteLoadingState());
        String accessToken = SharedPreferenceServices.getAccessToken() ?? "";
        String message = await noteRepository.createNote(
          accessToken: accessToken,
          noteTitle: event.noteTitle,
          noteDescription: event.noteDescription,
        );
        emit(NoteSucessState(message: message));
        // again fetching the all the notes after new one is added
        add(LoadNoteEvent());
      } on CustomException catch (e) {
        emit(NoteFailedState(message: e.message));
      } catch (e) {
        emit(NoteFailedState(message: "Something went wrong"));
      }
    }
  }
}
