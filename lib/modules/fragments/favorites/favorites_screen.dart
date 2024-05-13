import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/modules/fragments/favorites/favorites_controller.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            VietmapGL(
              myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
              myLocationEnabled: true,
              trackCameraPosition: true,
              styleString: 'https://maps.vietmap.vn/api/maps/light/styles.json?apikey=506862bb03a3d71632bdeb7674a3625328cb7e5a9b011841',
              initialCameraPosition: const CameraPosition(target: LatLng(10.762317, 106.654551)),
              onMapCreated: (VietmapController mapController) {
                controller.mapController.value = mapController;
              },
            ),
            controller.mapController.value == null
                ? const SizedBox.shrink()
                : MarkerLayer(markers: [
                    Marker(
                        alignment: Alignment.bottomCenter,
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                        latLng: const LatLng(10.762317, 106.654551)),
                    Marker(
                        alignment: Alignment.bottomCenter,
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                        latLng: const LatLng(12.25, 109.1833333)),
                    Marker(
                        alignment: Alignment.bottomCenter,
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                        latLng: const LatLng(22.356464, 103.873802))
                  ], mapController: controller.mapController.value!)
          ],
        );
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              controller.mapController.value?.addPolyline(const PolylineOptions());
            },
            tooltip: 'Draw a polyLine',
            child: const Icon(Icons.route),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              controller.mapController.value?.addPolyline(const PolylineOptions());
            },
            tooltip: 'Remove a polyLine',
            child: const Icon(Icons.shape_line),
          ),
        ],
      ),
    );
  }
}
