import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/core/utils/styles.dart';
import 'package:notes_app/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/features/notes/presentation/cubits/notes_cubit/notes_state.dart';

class AddNoteBottomSheet extends StatefulWidget {
  const AddNoteBottomSheet({super.key});

  @override
  State<AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state is NoteAdded) {
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 32.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF444444),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text('Add note', style: Styles.titleMedium),
            SizedBox(height: 16.h),
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFFAAAAAA)),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: Styles.labelSmall,
                filled: true,
                fillColor: const Color(0xFF111111),
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
            SizedBox(height: 10.h),
            TextField(
              controller: _descController,
              maxLines: 4,
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFFAAAAAA)),
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: Styles.labelSmall,
                filled: true,
                fillColor: const Color(0xFF111111),
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
            SizedBox(height: 16.h),
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
                            context.read<NotesCubit>().addNote(
                              title: _titleController.text.trim(),
                              description: _descController.text.trim(),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: state is NoteAdding
                        ? const CircularProgressIndicator(color: Colors.black)
                        : Text(
                            'Save',
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
    );
  }
}
