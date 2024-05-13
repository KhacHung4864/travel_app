import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/gen/assets.gen.dart';

class CategoryWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function()? onTap;

  const CategoryWidget({super.key, required this.image, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 38.h,
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
          onPressed: onTap,
          child: Row(
            children: [
              FadeInImage(
                fit: BoxFit.cover,
                height: 20.h,
                placeholder: Assets.images.placeHolder.provider(),
                image: NetworkImage(
                  image,
                ),
                imageErrorBuilder: (context, error, stackTraceError) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                    ),
                  );
                },
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(title, style: AppFont.t.s(12).w600.black7C838D)
            ],
          ),
        ));
  }
}
