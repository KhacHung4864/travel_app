import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/modules/fragments/search_place/search_item_controller.dart';
import 'package:travel_app/modules/fragments/widgets/popular_widget.dart';
import 'package:travel_app/routes/app_pages.dart';

class SearchScreen extends GetView<SearchItemController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: showSearchBarWidget(),
            ),
            controller.isLoading.value
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 8, 8),
                    child: Text(
                      controller.listPlaceSearch.isEmpty ? "No item found" : "Search Results: ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.searchPlaces(keyword: controller.searchController.text, listPlace: controller.listPlaceSearch, loading: false);
                },
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.listPlaceSearch.length,
                    itemBuilder: (context, index) {
                      var item = controller.listPlaceSearch[index];
                      return PopularWidget(
                        onTap: () {
                          Get.toNamed(Routes.placeDetail, arguments: [item]);
                        },
                        address: item.address ?? '',
                        desc: item.description ?? '',
                        price: item.price ?? 0,
                        title: item.name ?? '',
                        image: item.images?.first ?? '',
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ));
  }

  Widget showSearchBarWidget() {
    return TextField(
      style: AppFont.t.black,
      controller: controller.searchController,
      onSubmitted: (value) {
        controller.searchPlaces(keyword: controller.searchController.text, listPlace: controller.listPlaceSearch);
      },
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: () {
            controller.searchPlaces(keyword: controller.searchController.text, listPlace: controller.listPlaceSearch);
          },
          icon: const Icon(
            Icons.search,
            color: Palette.primary,
          ),
        ),
        hintText: 'Search best place here...',
        hintStyle: AppFont.t.grey.s(12),
        suffixIcon: IconButton(
          onPressed: () {
            controller.searchController.clear();
          },
          icon: const Icon(
            Icons.close,
            color: Palette.black,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.w,
            color: Palette.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.w,
            color: Palette.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.w,
            color: Palette.primary,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
      ),
    );
  }

  // Widget showSearchBarWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 18),
  //     child: TextField(
  //       style: const TextStyle(color: Colors.white),
  //       controller: controller.searchController,
  //       decoration: InputDecoration(
  //         prefixIcon: IconButton(
  //           onPressed: () {
  //             controller.searchPlaces(keyword: controller.searchController.text, listPlace: controller.listPlaceSearch);
  //           },
  //           icon: const Icon(
  //             Icons.search,
  //             color: Palette.white,
  //           ),
  //         ),
  //         hintText: "Search best place here...",
  //         hintStyle: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 12,
  //         ),
  //         suffixIcon: IconButton(
  //           onPressed: () {
  //             controller.searchController.clear();
  //           },
  //           icon: const Icon(
  //             Icons.close,
  //             color: Palette.white,
  //           ),
  //         ),
  //         enabledBorder: const OutlineInputBorder(
  //           borderSide: BorderSide(
  //             width: 2,
  //             color: Palette.blue00A9E7,
  //           ),
  //         ),
  //         focusedBorder: const OutlineInputBorder(
  //           borderSide: BorderSide(
  //             width: 2,
  //             color: Palette.white,
  //           ),
  //         ),
  //         contentPadding: const EdgeInsets.symmetric(
  //           horizontal: 16,
  //           vertical: 10,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
