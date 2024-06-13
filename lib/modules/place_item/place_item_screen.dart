import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/gen/assets.gen.dart';
import 'package:travel_app/modules/fragments/widgets/comment_widget.dart';
import 'package:travel_app/modules/fragments/widgets/preview_image.dart';
import 'package:travel_app/modules/map/google_map/open_google_map.dart';
import 'package:travel_app/modules/place_item/place_item_controller.dart';
import 'package:travel_app/routes/app_pages.dart';

class PlaceItemPage extends GetView<PlaceItemController> {
  const PlaceItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                left: 0.w,
                right: 0.w,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 380.h,
                  placeholder: Assets.images.placeHolder.provider(),
                  image: controller.isLoading.value ? Assets.images.placeHolder.provider() : NetworkImage(controller.placeItem.images![1]),
                  imageErrorBuilder: (context, error, stackTraceError) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                right: 10.w,
                top: 10.h,
                left: 10.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            size: 18.sp,
                            Icons.keyboard_arrow_left_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.map, arguments: [controller.placeItem]);
                      },
                      child: Container(
                        height: 40.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            size: 18.sp,
                            Icons.location_on,
                            color: const Color.fromARGB(255, 255, 40, 40),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        MapUtils.openMap(controller.placeItem.latitude!, controller.placeItem.longitude!);
                      },
                      child: Container(
                        height: 40.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            size: 18.sp,
                            Icons.map_outlined,
                            color: const Color.fromARGB(255, 255, 40, 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0.w,
                right: 0.w,
                top: 380 - 110,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 37.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.r),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.placeItem.name ?? '', style: AppFont.t.s(18).w700.textColor),
                                SizedBox(
                                  height: 8.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.map, arguments: [controller.placeItem]);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Palette.primary,
                                        size: 16.r,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Text(controller.placeItem.address ?? '', style: AppFont.t.s(14).w600.textColor),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("\$${controller.placeItem.price ?? ''}", maxLines: 1, overflow: TextOverflow.ellipsis, style: AppFont.t.s(18).w700.primary),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text("/Person", style: AppFont.t.s(10).w500.secondTextColor)
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Text(controller.placeItem.description ?? '', style: AppFont.t.s(12).w400.secondTextColor),
                        SizedBox(
                          height: 22.sp,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Spacer(),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  Get.toNamed(Routes.chatGPT, arguments: [controller.placeItem]);
                                },
                                child: Row(
                                  children: [
                                    Text("Chat Bot Review", style: AppFont.t.s(12).w400.black7C838D),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Palette.blue255,
                                      size: 12.r,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Preview", style: AppFont.t.s(18).w700.textColor),
                            Container(
                              height: 30.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Palette.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    size: 18.sp,
                                    Icons.star,
                                    color: const Color.fromARGB(255, 248, 229, 1),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                    controller.placeItem.rate?.toStringAsFixed(1) ?? '',
                                    style: AppFont.t.s(12).w400.secondTextColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var item in controller.placeItem.images ?? []) PreviewImage(image: item),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Text("Review", style: AppFont.t.s(18).w700.textColor),
                            const Spacer(),
                            // Container(
                            //   width: 100.w,
                            //   padding: const EdgeInsets.all(5),
                            //   decoration: BoxDecoration(
                            //     color: Palette.primary,
                            //     borderRadius: BorderRadius.circular(8.r),
                            //   ),
                            //   child: Material(
                            //     color: Colors.transparent,
                            //     child: InkWell(
                            //       splashColor: Colors.white,
                            //       onTap: () async {
                            //         final bool check = await showReview(context);
                            //         if (check == false) {
                            //           controller.createComment(rate: controller.rating.value, comment: controller.commentController.text);
                            //         }
                            //       },
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             "Comment",
                            //             style: AppFont.t.s(14).w700.white,
                            //           ),
                            //           const Spacer(),
                            //           const Icon(
                            //             Icons.comment,
                            //             color: Colors.white,
                            //             size: 20,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.only(top: 12.r, right: 12.r, bottom: 12.r),
                            child: Column(
                              children: [
                                for (var item in controller.listComments)
                                  CommentWidget(
                                    onDelete: () async {
                                      final bool check = await showDelete(context);
                                      if (check) {
                                        controller.deleteComment(commentItem: item);
                                      }
                                    },
                                    onEdit: () async {
                                      final bool check = await showReview(context, rate: item.rate, comment: item.comment, isEdit: true);
                                      if (check) {
                                        controller.updateComment(commentId: item.id, rate: controller.rating.value, comment: controller.commentController.text);
                                      }
                                    },
                                    isShowUpdate: item.userId == controller.dashboardFragmentsController.currentUser.value?.id,
                                    avatarUrl: item.user?.avatar ?? '',
                                    userName: item.user?.username ?? '',
                                    comment: item.comment ?? '',
                                    rating: item.rate ?? 0,
                                    commentTime: DateTime.parse(item.createdAt ?? '').toLocal(),
                                  ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 48.h,
                          width: 325.w,
                          decoration: BoxDecoration(
                            color: Palette.primary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () async {
                                final bool check = await showReview(context);
                                if (check == false) {
                                  controller.createComment(rate: controller.rating.value, comment: controller.commentController.text);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Comment",
                                    style: AppFont.t.s(18).w700.white,
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.comment,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<dynamic> showReview(BuildContext context, {int? rate, String? comment, bool isEdit = false}) {
    controller.rating.value = rate ?? 0;
    controller.commentController.text = comment ?? '';
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Comment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller.commentController,
                decoration: const InputDecoration(
                  hintText: 'Enter your comment',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      icon: Icon(
                        index < controller.rating.value ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        controller.rating.value = index + 1;
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(result: isEdit);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showDelete(BuildContext context, {int? rate, String? comment, bool isEdit = false}) {
    controller.rating.value = rate ?? 0;
    controller.commentController.text = comment ?? '';
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete comment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Are you sure you want to delete your comment", style: AppFont.t.s(18).w500.secondTextColor)],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(result: true);
              },
              child: Text('Delete', style: AppFont.t.w500.red),
            ),
          ],
        );
      },
    );
  }
}
