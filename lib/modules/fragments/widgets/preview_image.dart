import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/gen/assets.gen.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({super.key, required this.image, this.onTap});

  final String image;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            insetPadding: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.only(bottom: 40),
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  InteractiveViewer(
                    child: Image.network(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: FadeInImage(
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
      ),
    );
  }
}
