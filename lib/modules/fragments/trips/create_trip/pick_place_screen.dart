import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/data/model/places/place_trip_model.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.done, color: Colors.white),
            onPressed: () async {
              await controller.createTrip();
              controller.tripController.getListTrips();
              Get.back();
              Get.back();
            },
          ),
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  dayItem(),
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
                      child: controller.placeTripsByDate[controller.selectedDate.value]!.isEmpty
                          ? const Center(child: Text("Add Place Now"))
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: controller.placeTripsByDate[controller.selectedDate.value]!.map((placeTrip) {
                                  return PickPlaceItem(
                                    context: context,
                                    selectedTime: controller.selectedTime,
                                    selectedVehicle: controller.selectedVehicle,
                                    controller: controller,
                                    placeTrip: placeTrip,
                                  );
                                }).toList(),
                              ),
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
                      color: Palette.primary,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        onTap: () async {
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
        );
      }),
    );
  }

  Column dayItem() {
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
                                      '${controller.placeTripsByDate[e]!.length} places',
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
    required this.controller,
    required this.placeTrip,
  });

  final BuildContext context;
  final CreateTripController controller;
  final PlaceTrip placeTrip;
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
      initialTime: TimeOfDay(hour: placeTrip.startTime! ~/ 60, minute: placeTrip.startTime! % 60),
    );
    if (picked != null) {
      selectedTime.value = picked;
      placeTrip.startTime = picked.hour * 60 + picked.minute;
      print(selectedTime.value);
      print(placeTrip.startTime! ~/ 60);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 5),
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
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.placeDetail, arguments: [placeTrip.id]);
                },
                child: FadeInImage(
                  fit: BoxFit.cover,
                  width: 100,
                  height: 120,
                  placeholder: Assets.images.placeHolder.provider(),
                  image: NetworkImage(placeTrip.images!.first),
                  imageErrorBuilder: (context, error, stackTraceError) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: 100,
                color: Palette.blueFF0D6EFD,
                child: InkWell(
                  onTap: () => selectTime(context),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatTime(TimeOfDay(hour: placeTrip.startTime! ~/ 60, minute: placeTrip.startTime! % 60)),
                          style: AppFont.t.s(13).w700.white,
                        ),
                        const SizedBox(width: 5),
                        if (selectedTime.value == const TimeOfDay(hour: 0, minute: 0)) const SizedBox.shrink(),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                          color: Colors.white,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                placeTrip.name ?? '',
                style: AppFont.t.s(14).w600,
                overflow: TextOverflow.ellipsis,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
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
                          MapUtils.openMap(placeTrip.latitude!, placeTrip.longitude!);
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
                  const SizedBox(width: 50),
                  vehicle(),
                ],
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Remove Place'),
                    content: Text('Are you want Remove ${placeTrip.name} to your trip?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          controller.placeTripsByDate[controller.selectedDate.value]!.remove(placeTrip);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
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
          if (selectedVehicle.value == 0) const SizedBox.shrink(),
          DropdownButton(
            value: placeTrip.vehicle,
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
              placeTrip.vehicle = value;
            },
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
            elevation: 16,
            underline: const SizedBox.shrink(),
          ),
          Text(
            '${placeTrip.distance?.toStringAsFixed(2)}km',
            style: AppFont.t.s(12).w600.grey,
          ),
        ],
      );
    });
  }

  Future<void> showNoteDialog(BuildContext context) async {
    TextEditingController textController = TextEditingController();
    textController.text = placeTrip.note!;
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
                placeTrip.note = textController.text;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
