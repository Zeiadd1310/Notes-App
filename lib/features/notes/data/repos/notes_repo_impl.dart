import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';
import 'notes_repo.dart';

class NotesRepoImpl implements NotesRepo {
  final CollectionReference _collection = FirebaseFirestore.instance.collection(
    'notes',
  );

  @override
  Stream<List<NoteModel>> getNotes() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => NoteModel.fromDoc(doc)).toList(),
        );
  }

  @override
  Future<void> addNote({
    required String title,
    required String description,
  }) async {
    await _collection.add({
      'title': title,
      'description': description,
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Future<void> deleteNote(String id) async {
    await _collection.doc(id).delete();
  }

  @override
  Future<void> updateNote({
    required String id,
    required String title,
    required String description,
  }) async {
    await _collection.doc(id).update({
      'title': title,
      'description': description,
    });
  }
}
