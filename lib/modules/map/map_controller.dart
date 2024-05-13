import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/places/place_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';

class MapController extends GetxController {
  MapController();
  final HomeApi _homeApi = HomeApi();
  Places? placeItem = Get.arguments[0];

  //Map
  Rx<VietmapController?> mapController = Rx<VietmapController?>(null);
  Position? position;
  Rx<Line?> line = Rx<Line?>(null);

  RxBool isShowMyLocation = false.obs;

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  void getCurrentLocation() async {
    position = await checkPermisson();
  }

  Future<Position> checkPermisson() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
