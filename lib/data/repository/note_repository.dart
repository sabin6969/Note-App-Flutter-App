import 'package:note_app_flutter_mobile_app/data/models/note_model.dart';
import 'package:note_app_flutter_mobile_app/data/provider/note_provider.dart';

abstract class KNoteRepository {
  Future<List<Note>> getAllNotes({required String accessToken});
}

class NoteRepository extends KNoteRepository {
  final NoteProvider noteProvider;
  NoteRepository({required this.noteProvider});
  @override
  Future<List<Note>> getAllNotes({required String accessToken}) async {
    return await noteProvider.getAllNotes(accessToken: accessToken);
  }
}
