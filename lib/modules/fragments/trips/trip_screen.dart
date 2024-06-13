import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/data/model/list_trip_model.dart';
import 'package:travel_app/routes/app_pages.dart';

import 'trip_controller.dart';

class TripScreen extends GetView<TripController> {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Trip',
          style: AppFont.t.s(20).w700.white,
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Palette.primary,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getListTrips(isShowloading: false);
        },
        child: Obx(() {
          return controller.listTrips.isEmpty
              ? const Center(
                  child: Text('Create New Trip Now',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                )
              : ListView.builder(
                  itemCount: controller.listTrips.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          controller.selectedTrip = controller.listTrips[index];
                          controller.isEdit = true;
                          Get.toNamed(Routes.createTrip);
                        },
                        child: TripCard(
                          trip: controller.listTrips[index],
                          controller: controller,
                        ));
                  },
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isEdit = false;
          Get.toNamed(Routes.createTrip);
        },
        tooltip: 'Create Trip',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final Trips trip;
  final TripController controller;

  const TripCard({super.key, required this.trip, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    trip.name ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Remove Trip'),
                          content: Text('Do you want to remove ${trip.name}?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await controller.removeTrip(tripID: trip.id);
                                controller.listTrips.remove(trip);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                    size: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.date_range, color: Colors.green[700]),
                const SizedBox(width: 5),
                Text(
                  'Start: ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(trip.fromDate! * 1000))}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Spacer(),
                Icon(Icons.date_range, color: Colors.orange[700]),
                const SizedBox(width: 5),
                Text(
                  'End: ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(trip.toDate! * 1000))}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blue[700]),
                    const SizedBox(width: 5),
                    Text(
                      'Days: ${trip.days?.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 125),
                Row(
                  children: [
                    Icon(Icons.monetization_on, color: Colors.yellow[700]),
                    const SizedBox(width: 5),
                    Text(
                      'Fee: ${trip.tripFee}\$',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
