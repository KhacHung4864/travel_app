import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/gen/assets.gen.dart';

class PlaceByCategoryItem extends StatelessWidget {
  final String judul;
  final String tempat;
  final int harga;
  final String gambar;

  final Function()? onTap;

  const PlaceByCategoryItem({
    super.key,
    required this.judul,
    required this.tempat,
    required this.harga,
    required this.gambar,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        InkWell(
          onTap: onTap,
          splashColor: const Color.fromARGB(255, 245, 242, 242),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.r),
            ),
            child: FadeInImage(
              fit: BoxFit.cover,
              width: 222.w,
              height: 143.h,
              placeholder: Assets.images.placeHolder.provider(),
              image: NetworkImage(
                gambar,
              ),
              imageErrorBuilder: (context, error, stackTraceError) {
                return const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                  ),
                );
              },
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          child: Container(
            // height: 52.h,
            width: 222.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(13.r),
                bottomRight: Radius.circular(13.r),
              ),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 14.w, left: 14.w, top: 6.h, bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(judul, style: AppFont.t.s(12).w700.thirdTextColor),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Palette.thirdTextColor,
                            size: 10.r,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(tempat, style: AppFont.t.s(10).w600.thirdTextColor),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("\$ $harga", style: AppFont.t.s(12).w700.thirdTextColor),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 4.w,
                          ),
                          Text("/person", style: AppFont.t.s(10).w600.thirdTextColor),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // child: Text("Halo"),
      ],
    );
  }
}
