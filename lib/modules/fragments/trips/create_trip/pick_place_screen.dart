import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/gen/assets.gen.dart';
import 'package:travel_app/modules/fragments/trips/create_trip/create_trip_controller.dart';
import 'package:travel_app/modules/map/google_map/open_google_map.dart';
import 'package:travel_app/routes/app_pages.dart';

class PickPlaceScreen extends GetView<CreateTripController> {
  const PickPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit trip plan',
          style: AppFont.t.s(18).w700.black,
        ),
        centerTitle: true,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                genderItem(),
                const SizedBox(height: 5),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PickPlaceItem(
                          context: context,
                          selectedTime: controller.selectedTime,
                          selectedVehicle: controller.selectedVehicle,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: Get.width,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Palette.blueFF0D6EFD,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        controller.getCurrentLocation();
                        Get.toNamed(Routes.addPlace);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Add Place',
                            style: AppFont.t.s(14).w600.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Column genderItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return Container(
            decoration: BoxDecoration(
              color: Palette.blackF6F6F8,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                DropdownButton<String>(
                  value: controller.selectedDate.value,
                  items: controller.listDate
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Builder(
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 0),
                                  ),
                                ]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e,
                                          style: AppFont.t.s(15).w700.copyWith(color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      '11 places',
                                      style: AppFont.t.s(14).w700.copyWith(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.selectedDate.value = value!;
                  },
                  isExpanded: true,
                  elevation: 16,
                  icon: const SizedBox.shrink(),
                  underline: const SizedBox.shrink(),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class PickPlaceItem extends StatelessWidget {
  const PickPlaceItem({
    super.key,
    required this.context,
    required this.selectedTime,
    required this.selectedVehicle,
  });

  final BuildContext context;
  final Rx<TimeOfDay?> selectedTime;
  final Rx<int> selectedVehicle;

  String formatTime(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value!,
    );
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(0, 0),
        ),
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              FadeInImage(
                fit: BoxFit.cover,
                width: 95,
                height: 100,
                placeholder: Assets.images.placeHolder.provider(),
                image: const NetworkImage('https://photo.znews.vn/w960/Uploaded/qhj_yvobvhfwbv/2018_07_18/Nguyen_Huy_Binh1.jpg'),
                imageErrorBuilder: (context, error, stackTraceError) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                    ),
                  );
                },
              ),
              Container(
                width: 95,
                color: Palette.blueFF0D6EFD,
                child: InkWell(
                  onTap: () => selectTime(context),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatTime(selectedTime.value!),
                          style: AppFont.t.s(13).w700.white,
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                          color: Colors.white,
                        ),
                      ],
                    );
                  }),
                ),
              )
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                'Ha Noi',
                style: AppFont.t.s(14).w600,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Visit time:  ',
                    style: AppFont.t.s(12).w600.grey,
                  ),
                  Text(
                    '30p',
                    style: AppFont.t.s(12).w600.blueFF0D6EFD,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showNoteDialog(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.note_alt,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Note',
                      style: AppFont.t.s(12).w600.blueFF0D6EFD,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  MapUtils.openMap(112, 20);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.map,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Map',
                      style: AppFont.t.s(12).w600.blueFF0D6EFD,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 60),
          vehicle(),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.close,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicle() {
    return Obx(() {
      return Column(
        children: [
          const SizedBox(height: 65),
          DropdownButton(
            value: selectedVehicle.value,
            items: const [
              DropdownMenuItem(
                value: 2,
                child: Icon(
                  Icons.directions_car,
                  color: Colors.blue,
                ),
              ),
              DropdownMenuItem(
                value: 1,
                child: Icon(
                  Icons.two_wheeler,
                  color: Colors.blue,
                ),
              ),
              DropdownMenuItem(
                value: 3,
                child: Icon(
                  Icons.flight,
                  color: Colors.blue,
                ),
              ),
              DropdownMenuItem(
                value: 4,
                child: Icon(
                  Icons.directions_boat,
                  color: Colors.blue,
                ),
              ),
            ],
            onChanged: (value) {
              selectedVehicle.value = value!;
            },
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
            elevation: 16,
            underline: const SizedBox.shrink(),
          ),
          Text(
            '170m | 0p',
            style: AppFont.t.s(12).w600.grey,
          ),
        ],
      );
    });
  }

  Future<void> showNoteDialog(BuildContext context) async {
    TextEditingController textController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter notes'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Your notes'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
