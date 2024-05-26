import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/gen/assets.gen.dart';
import 'package:travel_app/modules/fragments/home/home_controller.dart';
import 'package:travel_app/modules/fragments/widgets/category_widget.dart';
import 'package:travel_app/modules/fragments/widgets/judul_widget.dart';
import 'package:travel_app/modules/fragments/widgets/place_by_category_item.dart';
import 'package:travel_app/modules/fragments/widgets/popular_widget.dart';
import 'package:travel_app/routes/app_pages.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await controller.initData(isShowLoading: false);
        },
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Obx(() {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    viewportFraction: 0.85,
                  ),
                  items: controller.listBanner.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: 300,
                                placeholder: Assets.images.placeHolder.provider(),
                                image: NetworkImage(
                                  i.image ?? '',
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
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                i.name ?? '',
                                style: AppFont.t.s(15).w600.white,
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }).toList(),
                );
              }),
              SizedBox(
                height: 36.w,
              ),
              const JudulWidget(judul: "Category"),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return SizedBox(
                  height: 50,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: controller.listCategory.map((item) {
                        return InkWell(
                          onTap: () {
                            controller.getPlaces(categoryId: item.id, listPlace: controller.listPlaceByCategory, isLoading: true);
                          },
                          child: CategoryWidget(image: item.icon ?? '', title: item.name ?? ''),
                        );
                      }).toList()),
                );
              }),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return SizedBox(
                  height: 143.h,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: controller.listPlaceByCategory.map((item) {
                        return PlaceByCategoryItem(
                          onTap: () {
                            Get.toNamed(Routes.placeDetail, arguments: [item]);
                          },
                          gambar: item.images?.first ?? '',
                          harga: item.price ?? 0,
                          judul: item.name ?? '',
                          tempat: item.address ?? '',
                        );
                      }).toList()),
                );
              }),
              SizedBox(
                height: 36.h,
              ),
              const JudulWidget(judul: "Popular Destination"),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return Column(
                  children: [
                    for (var item in controller.listPlace)
                      PopularWidget(
                        onTap: () {
                          Get.toNamed(Routes.placeDetail, arguments: [item]);
                        },
                        address: item.address ?? '',
                        desc: item.description ?? '',
                        price: item.price ?? 0,
                        title: item.name ?? '',
                        image: item.images?.first ?? '',
                      ),
                  ],
                );
              }),
              SizedBox(
                height: 100.h,
              )
            ],
          ),
        )));
  }
}
