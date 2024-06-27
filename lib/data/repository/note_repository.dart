import 'package:note_app_flutter_mobile_app/data/models/note_model.dart';
import 'package:note_app_flutter_mobile_app/data/provider/note_provider.dart';

abstract class KNoteRepository {
  Future<List<Note>> getAllNotes({required String accessToken});
  Future<String> createNote({
    required String accessToken,
    required String noteTitle,
    required String noteDescription,
  });
  Future<String> deleteNote(
      {required String accessToken, required String noteId});
}

class NoteRepository extends KNoteRepository {
  final NoteProvider noteProvider;
  NoteRepository({required this.noteProvider});
  @override
  Future<List<Note>> getAllNotes({required String accessToken}) async {
    return await noteProvider.getAllNotes(accessToken: accessToken);
  }

  @override
  Future<String> createNote({
    required String accessToken,
    required String noteTitle,
    required String noteDescription,
  }) {
    return noteProvider.createNote(
      accessToken: accessToken,
      noteTitle: noteTitle,
      noteDescription: noteDescription,
    );
  }

  @override
  Future<String> deleteNote(
      {required String accessToken, required String noteId}) async {
    return await noteProvider.deleteNote(
        accessToken: accessToken, noteId: noteId);
  }
}
