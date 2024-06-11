import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/routes/app_pages.dart';

class TripScreen extends StatelessWidget {
  final List<String> trips = ['Trip to Paris', 'Trip to London', 'Trip to Tokyo'];

  TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Trips', style: AppFont.t.s(21).w700.white),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(trips[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.createTrip);
        },
        tooltip: 'Create Trip',
        child: const Icon(Icons.add),
      ),
    );
  }
}
