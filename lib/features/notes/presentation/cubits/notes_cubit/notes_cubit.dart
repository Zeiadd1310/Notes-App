import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:notes_app/features/notes/data/repos/notes_repo.dart';

import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepo notesRepo;
  StreamSubscription? _notesSubscription;

  NotesCubit(this.notesRepo) : super(NotesInitial());

  void listenToNotes() {
    emit(NotesLoading());
    _notesSubscription = notesRepo.getNotes().listen(
      (notes) => emit(NotesLoaded(notes)),
      onError: (e) => emit(NotesError(e.toString())),
    );
  }

  Future<void> addNote({
    required String title,
    required String description,
  }) async {
    try {
      emit(NoteAdding());
      await notesRepo.addNote(title: title, description: description);
      emit(NoteAdded());
      _notesSubscription?.cancel();
      _notesSubscription = notesRepo.getNotes().listen(
        (notes) => emit(NotesLoaded(notes)),
        onError: (e) => emit(NotesError(e.toString())),
      );
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      emit(NoteDeleting());
      await notesRepo.deleteNote(id);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String description,
  }) async {
    try {
      emit(NoteUpdating());
      await notesRepo.updateNote(
        id: id,
        title: title,
        description: description,
      );
      emit(NoteAdded());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
