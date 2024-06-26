import 'package:note_app_flutter_mobile_app/data/models/note_model.dart';

final class NoteState {}

final class NoteInitialState extends NoteState {}

final class NoteLoadingState extends NoteState {}

final class NoteSucessState extends NoteState {
  final String message;
  NoteSucessState({required this.message});
}

final class NoteFailedState extends NoteState {
  final String message;
  NoteFailedState({required this.message});
}

final class NoteValidationFailedState extends NoteState {
  final String message;
  NoteValidationFailedState({required this.message});
}

final class NoteLoadedState extends NoteState {
  List<Note> notes;
  NoteLoadedState({required this.notes});
}

final class NoteLoadingFailedState extends NoteState {
  String errorMessage;
  NoteLoadingFailedState({required this.errorMessage});
}
