import '../models/note_model.dart';

abstract class NotesRepo {
  Stream<List<NoteModel>> getNotes();

  Future<void> addNote({required String title, required String description});

  Future<void> deleteNote(String id);

  Future<void> updateNote({
    required String id,
    required String title,
    required String description,
  });
}
