final class NoteEvent {}

final class LoadNoteEvent extends NoteEvent {}

final class AddNoteEvent extends NoteEvent {
  String noteTitle;
  String noteDescription;
  AddNoteEvent({required this.noteDescription, required this.noteTitle});
}

final class DeleteNoteEvent extends NoteEvent {
  String noteId;
  DeleteNoteEvent({required this.noteId});
}

final class UpdateNoteEvent extends NoteEvent {
  String noteTitle;
  String noteId;
  String noteDescription;
  UpdateNoteEvent(
      {required this.noteDescription,
      required this.noteId,
      required this.noteTitle});
}
