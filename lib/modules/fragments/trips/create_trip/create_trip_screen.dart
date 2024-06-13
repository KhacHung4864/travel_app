import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/modules/fragments/trips/create_trip/create_trip_controller.dart';
import 'package:travel_app/routes/app_pages.dart';

class CreateTripScreen extends GetView<CreateTripController> {
  CreateTripScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (controller.tripController.isEdit == true) ? 'Edit Trip' : 'Create Trip',
          style: AppFont.t.s(20).w700.white,
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Palette.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: controller.tripName,
                  decoration: InputDecoration(
                    labelText: 'Trip Name',
                    labelStyle: AppFont.t.s(16).w600.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Palette.blackF6F6F8,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a trip name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.tripName.text = value!;
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          controller.isCheck.value = false;
                          var pickDate = await showDatePicker(
                              context: context,
                              initialDate: controller.startDate.value != 0 ? DateTime.fromMillisecondsSinceEpoch(controller.startDate.value) : DateTime.now(),
                              firstDate: DateTime(1700),
                              lastDate: controller.returnDate.value != 0 ? DateTime.fromMillisecondsSinceEpoch(controller.returnDate.value) : DateTime(3000));
                          if (pickDate != null) {
                            controller.startDate.value = pickDate.millisecondsSinceEpoch;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: Palette.blackF6F6F8,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.calendar_today, size: 25, color: Colors.blueAccent),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start date',
                                    style: AppFont.t.s(14).w600.black,
                                  ),
                                  Text(
                                    (controller.startDate.value == 0) ? 'dd/MM/yyyy'.tr : DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(controller.startDate.value)),
                                    style: AppFont.t.s(14).w600.copyWith(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          controller.isCheck.value = false;
                          var pickDate = await showDatePicker(
                              context: context,
                              initialDate: controller.returnDate.value != 0 ? DateTime.fromMillisecondsSinceEpoch(controller.returnDate.value) : DateTime.now(),
                              firstDate: controller.startDate.value != 0 ? DateTime.fromMillisecondsSinceEpoch(controller.startDate.value) : DateTime(1700),
                              lastDate: DateTime(3000));
                          if (pickDate != null) {
                            controller.returnDate.value = pickDate.millisecondsSinceEpoch;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: Palette.blackF6F6F8,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.calendar_today, size: 25, color: Colors.orangeAccent),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Return date',
                                    style: AppFont.t.s(14).w600.black,
                                  ),
                                  Text(
                                    (controller.returnDate.value == 0) ? 'dd/MM/yyyy'.tr : DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(controller.returnDate.value)),
                                    style: AppFont.t.s(14).w600.copyWith(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (controller.isCheck.value) const SizedBox(height: 5),
                if (controller.isCheck.value) Text('Please enter the trip days', style: AppFont.t.s(11).w500.red),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blueAccent),
                    const SizedBox(width: 10),
                    Text('Person', style: AppFont.t.s(15).w700.black),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.redAccent),
                      onPressed: () {
                        if (controller.person.value > 1) {
                          controller.person.value--;
                        }
                      },
                    ),
                    Obx(() => Text(
                          '${controller.person.value}',
                          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.greenAccent),
                      onPressed: () {
                        controller.person.value++;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.primary,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                  onPressed: () {
                    controller.checkDate();
                    if (formKey.currentState!.validate() && controller.isCheck.value == false) {
                      controller.updateDateList();
                      controller.selectedDate.value = controller.listDate.first;
                      Get.toNamed(Routes.pickPlace);
                      formKey.currentState!.save();
                    }
                  },
                  child: Text(
                    'Continue',
                    style: AppFont.t.s(16).w700.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
