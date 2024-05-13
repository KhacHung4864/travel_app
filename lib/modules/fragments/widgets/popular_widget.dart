import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/gen/assets.gen.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({
    super.key,
    required this.address,
    required this.desc,
    required this.price,
    required this.title,
    required this.image,
    this.onTap,
  });

  final String title;
  final String address;
  final String desc;
  final int price;
  final String image;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(children: [
          FadeInImage(
            fit: BoxFit.cover,
            width: 95.w,
            height: 85.h,
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
            width: 14.w,
          ),
          Expanded(
              child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppFont.t.s(14).w700.textColor),
              SizedBox(
                height: 6.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Palette.blue255,
                    size: 10.r,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(address, style: AppFont.t.s(10).w600.primary),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                desc,
                style: AppFont.t.s(9).w400.secondTextColor,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                children: [
                  Text("\$ $price", style: AppFont.t.s(12).w700.textColor),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    "/Person",
                    style: AppFont.t.s(10).w500.secondTextColor,
                  )
                ],
              ),
            ],
          ))
        ]),
      ),
    );
  }
}
