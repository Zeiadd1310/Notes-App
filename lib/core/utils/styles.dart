import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static final titleMedium = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: Color(0xFFFFFFFF),
  );
  static final titleSmall = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: Color(0xFFFFFFFF),
  );
  static final bodySmall = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xFF666666),
  );
  static final labelSmall = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xFF444444),
  );
}
