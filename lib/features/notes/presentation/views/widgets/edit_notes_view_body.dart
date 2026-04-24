import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/core/utils/styles.dart';
import 'package:notes_app/features/notes/data/models/note_model.dart';
import 'package:notes_app/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/features/notes/presentation/cubits/notes_cubit/notes_state.dart';

class EditNotesViewBody extends StatefulWidget {
  final NoteModel note;
  const EditNotesViewBody({super.key, required this.note});

  @override
  State<EditNotesViewBody> createState() => _EditNotesViewBodyState();
}

class _EditNotesViewBodyState extends State<EditNotesViewBody> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descController = TextEditingController(text: widget.note.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<NotesCubit>(),
      child: BlocListener<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is NoteAdded) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          backgroundColor: scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text('Edit Note', style: Styles.titleMedium),
                      ),
                    ),
                    SizedBox(width: 24.w),
                  ],
                ),
                SizedBox(height: 14.h),
                Divider(color: Color(0xFF444444)),
                SizedBox(height: 14.h),
                Text('TITLE', style: Styles.labelSmall),
                SizedBox(height: 8.h),
                TextField(
                  controller: _titleController,
                  style: Styles.titleMedium,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Text('DESCRIPTION', style: Styles.labelSmall),
                SizedBox(height: 8.h),
                TextField(
                  controller: _descController,
                  maxLines: 5,
                  style: Styles.titleMedium,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<NotesCubit, NotesState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is NoteAdding
                            ? null
                            : () {
                                if (_titleController.text.trim().isEmpty ||
                                    _descController.text.trim().isEmpty)
                                  return;
                                context.read<NotesCubit>().updateNote(
                                  id: widget.note.id,
                                  title: _titleController.text.trim(),
                                  description: _descController.text.trim(),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                        child: Text(
                          'Save changes',
                          style: Styles.titleSmall.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
