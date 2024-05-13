import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/modules/map/google_map/open_google_map.dart';
import 'package:travel_app/modules/map/map_controller.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';

class MapScreen extends GetView<MapController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return Stack(
            children: [
              VietmapGL(
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                myLocationEnabled: controller.isShowMyLocation.value,
                trackCameraPosition: true,
                styleString: 'https://maps.vietmap.vn/api/maps/light/styles.json?apikey=506862bb03a3d71632bdeb7674a3625328cb7e5a9b011841',
                initialCameraPosition: CameraPosition(
                  target: LatLng(controller.placeItem?.latitude ?? 0.0, controller.placeItem?.longitude ?? 0.0),
                  zoom: 11,
                ),
                onMapCreated: (VietmapController mapController) {
                  controller.mapController.value = mapController;
                  // if (controller.placeItem != null) {
                  //   controller.mapController.value?.moveCamera(CameraUpdate.newLatLng(
                  //     LatLng(controller.placeItem?.latitude ?? 0.0, controller.placeItem?.longitude ?? 0.0),
                  //   ));
                  // }
                },
              ),
              controller.mapController.value == null
                  ? const SizedBox.shrink()
                  : MarkerLayer(
                      markers: [
                        Marker(
                          alignment: Alignment.bottomCenter,
                          width: 50,
                          height: 50,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 50,
                          ),
                          latLng: LatLng(controller.placeItem?.latitude ?? 0.0, controller.placeItem?.longitude ?? 0.0),
                        ),
                        // Marker(
                        //   alignment: Alignment.bottomCenter,
                        //   width: 50,
                        //   height: 50,
                        //   child: const Icon(
                        //     Icons.location_on,
                        //     color: Colors.red,
                        //     size: 50,
                        //   ),
                        //   latLng: const LatLng(12.25, 109.1833333),
                        // ),
                        // Marker(
                        //   alignment: Alignment.bottomCenter,
                        //   width: 50,
                        //   height: 50,
                        //   child: const Icon(
                        //     Icons.location_on,
                        //     color: Colors.red,
                        //     size: 50,
                        //   ),
                        //   latLng: const LatLng(22.356464, 103.873802),
                        // )
                      ],
                      mapController: controller.mapController.value!,
                    ),
              Positioned(
                right: 10.w,
                top: 10.h,
                left: 10.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            size: 18.sp,
                            Icons.keyboard_arrow_left_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        controller.mapController.value?.animateCamera(
                          CameraUpdate.zoomIn(),
                        );
                      },
                      heroTag: 'zoomIn',
                      mini: true,
                      tooltip: 'Zoom In',
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      onPressed: () {
                        controller.mapController.value!.moveCamera(
                          CameraUpdate.zoomBy(
                            -0.5,
                          ),
                        );
                      },
                      heroTag: 'zoomOut',
                      mini: true,
                      tooltip: 'Zoom Out',
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                controller.isShowMyLocation.value = true;

                controller.mapController.value?.animateCamera(
                  CameraUpdate.newLatLngZoom(LatLng(controller.position!.latitude, controller.position!.longitude), 16),
                );
              },
              tooltip: 'show location now',
              child: const Icon(Icons.my_location),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () async {
                controller.line.value = await controller.mapController.value?.addPolyline(PolylineOptions(
                  geometry: [
                    LatLng(controller.position!.latitude, controller.position!.longitude),
                    LatLng(controller.placeItem?.latitude ?? 0.0, controller.placeItem?.longitude ?? 0.0),
                  ],
                  polylineColor: Colors.blue,
                  polylineWidth: 10,
                ));
              },
              tooltip: 'Draw a polyLine',
              child: const Icon(Icons.route),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                // controller.mapController.value?.removePolyline(controller.line.value!);
                DistanceCalculator calculator = DistanceCalculator();
                double distance = calculator.calculateDistance(
                  startLat: controller.position!.latitude,
                  startLng: controller.position!.longitude,
                  endLat: controller.placeItem?.latitude ?? 0.0,
                  endLng: controller.placeItem?.longitude ?? 0.0,
                );
                print('Distance: $distance km');
              },
              tooltip: 'Remove a polyLine',
              child: const Icon(Icons.shape_line),
            ),
          ],
        ),
      ),
    );
  }
}
