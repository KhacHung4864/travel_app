import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/gen/assets.gen.dart';
import 'package:travel_app/modules/fragments/profile/proflile_controller.dart';
import 'package:travel_app/routes/app_pages.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(16.sp), children: [
      _bannerProfile(),
      const SizedBox(height: 22),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 44,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            _profileItem(
                asset: Assets.svg.iconAccount,
                title: "My Account",
                content: "Make changes to your account",
                onTap: () {
                  Get.toNamed(Routes.account);
                }),
            const SizedBox(height: 25),
            _profileItem(asset: Assets.svg.iconLockAc, title: "Face ID/ Touch ID", content: "Make changes to your account", onTap: controller.showNotifiCation),
            const SizedBox(height: 25),
            _profileItem(asset: Assets.svg.iconAuthen, title: "Two-Factor Authentication", content: "Further secure your account for safety", onTap: controller.showNotifiCation),
            const SizedBox(height: 25),
            _profileItem(asset: Assets.svg.iconLogout, title: "Log out", content: "Further secure your account for safety", onTap: controller.signOutUser),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Text(
        "More",
        style: AppFont.t.s(14).w700.copyWith(color: const Color(0xFF181D27)),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 44,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            _profileItem(asset: Assets.svg.iconNotificaton, title: "Help & Support", onTap: controller.showNotifiCation),
            const SizedBox(height: 25),
            _profileItem(asset: Assets.svg.iconHeart, title: "About App", onTap: controller.showNotifiCation),
          ],
        ),
      ),
    ]);
  }

  Widget _profileItem({String? asset, String? title, String? content, Function()? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color.fromARGB(255, 245, 242, 242),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: ShapeDecoration(
                color: Palette.blueFF0600B3.withOpacity(0.05),
                shape: const OvalBorder(),
              ),
              child: Center(
                child: SvgPicture.asset(
                  asset ?? "",
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: AppFont.t.s(13).w700,
                  ),
                  if (content != null)
                    Text(
                      content,
                      style: AppFont.t.s(11).w500.copyWith(color: const Color(0xFFABABAB)),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFFABABAB),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerProfile() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: ShapeDecoration(
          color: Palette.blueFF0600B3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 44,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 53,
              width: 53,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: Palette.white,
                ),
                image: controller.dashboardFragmentsController.currentUser.value?.avatar == null
                    ? DecorationImage(image: Assets.images.man.provider(), fit: BoxFit.contain)
                    : DecorationImage(
                        image: NetworkImage(controller.dashboardFragmentsController.currentUser.value?.avatar ?? ''),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(width: 13),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.dashboardFragmentsController.currentUser.value?.username ?? '',
                  style: AppFont.t.s(14).w700.white,
                ),
                Text(
                  controller.dashboardFragmentsController.currentUser.value?.email ?? '',
                  style: AppFont.t.s(11).w400.white,
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Column userInforItem({String? title, bool isEmail = false, String? hintext, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: AppFont.t.s(12).copyWith(color: isEmail ? Palette.grey : Palette.blue),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
              errorStyle: AppFont.t.red.s(13),
              hintText: hintext,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 18,
              ),
              fillColor: Palette.blackF6F6F8,
              filled: true),
        )
      ],
    );
  }
}
