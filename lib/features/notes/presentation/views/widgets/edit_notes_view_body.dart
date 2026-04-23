import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/core/utils/styles.dart';

class EditNotesViewBody extends StatelessWidget {
  const EditNotesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                ),
                SizedBox(width: 95.w),
                Text('Edit Notes', style: Styles.titleMedium),
              ],
            ),
            SizedBox(height: 14.h),
            Divider(color: Color(0xFF444444)),
            SizedBox(height: 14.h),
            Text(
              'Title',
              style: Styles.titleMedium.copyWith(color: Color(0xff888888)),
            ),
            SizedBox(height: 14.h),

            Text(
              'Description',
              style: Styles.titleMedium.copyWith(color: Color(0xff888888)),
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text(
                  'Save changes',
                  style: Styles.titleSmall.copyWith(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
