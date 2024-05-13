import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/gen/assets.gen.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.cover,
      height: 90.h,
      width: 90.w,
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
    );
  }
}
