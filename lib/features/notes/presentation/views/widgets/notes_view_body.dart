import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/core/utils/app_router.dart';
import 'package:notes_app/core/utils/styles.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/add_note_bottom_sheet.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/note_card.dart';

class NotesViewBody extends StatelessWidget {
  const NotesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    padding: EdgeInsets.zero,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 14.h);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return NoteCard(
                        title: 'Test',
                        description:
                            'This is a testThis is a testThis is a testThis is a testThis is a testThis is a testThis is a testThis is a testThis is a testThis is a testThis is a testThis is a test',
                        date: '2022-01-01',
                        onDelete: () {},
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.kEditNoteView);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const AddNoteBottomSheet(),
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
          ),
        ],
      ),
    );
  }
}
