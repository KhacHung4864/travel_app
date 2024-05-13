import 'package:travel_app/data/model/category_model.dart';

class PlaceModel {
  int? code;
  Data? data;
  String? message;

  PlaceModel({this.code, this.data, this.message});

  PlaceModel.fromJson(Map<String, dynamic> json) {
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
  List<Places>? places;

  Data({this.places});

  Data.fromJson(Map<String, dynamic> json) {
    places = json["places"] == null ? null : (json["places"] as List).map((e) => Places.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (places != null) {
      _data["places"] = places?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Places {
  int? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  String? description;
  int? price;
  List<Categories>? categories;
  List<String>? images;
  String? createdAt;
  String? updatedAt;

  Places({this.id, this.name, this.address, this.latitude, this.longitude, this.description, this.price, this.categories, this.images, this.createdAt, this.updatedAt});

  Places.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    address = json["address"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    description = json["description"];
    price = json["price"];
    categories = json["categories"] == null ? null : (json["categories"] as List).map((e) => Categories.fromJson(e)).toList();
    images = json["images"] == null ? null : List<String>.from(json["images"]);
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["address"] = address;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["description"] = description;
    _data["price"] = price;
    if (categories != null) {
      _data["categories"] = categories?.map((e) => e.toJson()).toList();
    }
    if (images != null) {
      _data["images"] = images;
    }
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
