import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';

class JudulWidget extends StatelessWidget {
  final String judul;
  const JudulWidget({
    super.key,
    required this.judul,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(judul, style: AppFont.t.s(18).w700.black7C838D),
        const Spacer(),
        Text("View All", style: AppFont.t.s(12).w400.black7C838D),
        SizedBox(
          width: 4.w,
        ),
        Icon(
          Icons.arrow_forward,
          color: Palette.blue255,
          size: 12.r,
        )
      ],
    );
  }
}
