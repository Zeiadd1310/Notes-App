import 'package:notes_app/features/notes/data/models/note_model.dart';

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<NoteModel> notes;
  NotesLoaded(this.notes);
}

class NotesError extends NotesState {
  final String message;
  NotesError(this.message);
}

class NoteAdding extends NotesState {}

class NoteAdded extends NotesState {}

class NoteDeleting extends NotesState {}

class NoteUpdating extends NotesState {}
