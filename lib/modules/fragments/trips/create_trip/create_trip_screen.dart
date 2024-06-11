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
          'Create Trip',
          style: AppFont.t.s(20).w700.black,
        ),
        centerTitle: true,
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                  decoration: const InputDecoration(labelText: 'Trip Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a trip name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.tripName = value!;
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    GestureDetector(
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
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Palette.blackF6F6F8,
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.calendar_month, size: 25),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start date',
                                  style: AppFont.t.s(13).w700,
                                ),
                                Text(
                                  (controller.startDate.value == 0) ? 'dd/MM/yyyy'.tr : DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(controller.startDate.value)),
                                  style: AppFont.t.s(13).w700.copyWith(color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
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
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Palette.blackF6F6F8,
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.calendar_month, size: 25),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Return date',
                                  style: AppFont.t.s(13).w700,
                                ),
                                Text(
                                  (controller.returnDate.value == 0) ? 'dd/MM/yyyy'.tr : DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(controller.returnDate.value)),
                                  style: AppFont.t.s(13).w700.copyWith(color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
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
                    const SizedBox(width: 10),
                    const Icon(Icons.person),
                    const SizedBox(width: 10),
                    Text('Person', style: AppFont.t.s(15).w700.black),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (controller.person.value > 1) {
                              controller.person.value--;
                            }
                          },
                        ),
                        Text(
                          controller.person.toString(),
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              controller.person.value++;
                            }),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.checkDate();
                    if (formKey.currentState!.validate() && controller.isCheck.value == false) {
                      controller.listDate = controller.generateDateList(controller.startDate.value, controller.returnDate.value);
                      controller.selectedDate.value = controller.listDate.first;
                      Get.toNamed(Routes.pickPlace);
                      formKey.currentState!.save();
                    }
                  },
                  child: Text(
                    'Continue',
                    style: AppFont.t.s(16).w700.black,
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
