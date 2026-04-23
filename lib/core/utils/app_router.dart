import 'package:go_router/go_router.dart';
import 'package:notes_app/features/notes/presentation/views/notes_view.dart';

abstract class AppRouter {
  static const kNotesView = '/notesView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const NotesView()),
    ],
  );
}
