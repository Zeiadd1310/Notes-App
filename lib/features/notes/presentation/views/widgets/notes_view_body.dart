import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/core/utils/app_router.dart';
import 'package:notes_app/core/utils/styles.dart';
import 'package:notes_app/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/features/notes/presentation/cubits/notes_cubit/notes_state.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/add_note_bottom_sheet.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/note_card.dart';

class NotesViewBody extends StatelessWidget {
  const NotesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => BlocProvider.value(
              value: context.read<NotesCubit>(),
              child: const AddNoteBottomSheet(),
            ),
          );
        },
        child: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(Icons.add, color: Color(0xFF111111), size: 30.sp),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Notes', style: Styles.titleMedium),
                  SizedBox(height: 14.h),
                  Divider(color: Color(0xFF444444)),
                  SizedBox(height: 14.h),
                  BlocBuilder<NotesCubit, NotesState>(
                    builder: (context, state) {
                      if (state is NotesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      if (state is NotesError) {
                        return Center(
                          child: Text(state.message, style: Styles.bodySmall),
                        );
                      }

                      if (state is NotesLoaded) {
                        if (state.notes.isEmpty) {
                          return Center(
                            child: Text(
                              'No notes yet. Tap + to add one!',
                              style: Styles.bodySmall,
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.notes.length,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (_, __) => SizedBox(height: 14.h),
                          itemBuilder: (context, index) {
                            final note = state.notes[index];
                            return NoteCard(
                              title: note.title,
                              description: note.description,
                              date: note.createdAt.toDate().toString(),
                              onDelete: () {
                                context.read<NotesCubit>().deleteNote(note.id);
                              },
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).push(AppRouter.kEditNoteView, extra: note);
                              },
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
