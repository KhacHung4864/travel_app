import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/configs/palette.dart';

extension ColorExtension on TextStyle {
  TextStyle get primary => copyWith(color: Palette.primary);
  TextStyle get white => copyWith(color: Palette.white);
  TextStyle get red => copyWith(color: Palette.red);
  TextStyle get success => copyWith(color: Palette.success);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get black => copyWith(color: Palette.black);
  TextStyle get orange => copyWith(color: Palette.orange);
  TextStyle get grey66 => copyWith(color: Palette.gray66);
  TextStyle get grey => copyWith(color: Palette.grey);
  TextStyle get hint => copyWith(color: Palette.hint);
  TextStyle get blue => copyWith(color: Palette.blue);
  TextStyle get blue007EB8 => copyWith(color: Palette.blue007EB8);
  TextStyle get blue00A9E7 => copyWith(color: Palette.blue00A9E7);
  TextStyle get purpleAccent => copyWith(color: Palette.purpleAccent);
  TextStyle get deepPurple => copyWith(color: Palette.deppPurple);

  TextStyle get black7C838D => copyWith(color: Palette.black7C838D);

  TextStyle get blueFF0D6EFD => copyWith(color: Palette.blueFF0D6EFD);
  TextStyle get textColor => copyWith(color: Palette.textColor);

  TextStyle get secondTextColor => copyWith(color: Palette.secondTextColor);

  TextStyle get thirdTextColor => copyWith(color: Palette.thirdTextColor);
}

extension MyFontWeight on TextStyle {
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}

extension MyFontSize on TextStyle {
  TextStyle s([double size = 14]) => copyWith(fontSize: size.sp);
}

class AppFont {
  static TextStyle get t => TextStyle(
        color: Palette.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gilroy',
      );
}
