import 'package:travel_app/data/model/places/place_model.dart';

class PlaceDetailModel {
  int? code;
  Data? data;
  String? message;

  PlaceDetailModel({this.code, this.data, this.message});

  PlaceDetailModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    _data["message"] = message;
    return _data;
  }
}

class Data {
  Places? place;

  Data({this.place});

  Data.fromJson(Map<String, dynamic> json) {
    place = json["place"] == null ? null : Places.fromJson(json["place"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (place != null) {
      _data["place"] = place?.toJson();
    }
    return _data;
  }
}
