class PlaceTripModel {
  int? code;
  Data? data;
  String? message;

  PlaceTripModel({this.code, this.data, this.message});

  PlaceTripModel.fromJson(Map<String, dynamic> json) {
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
  List<PlaceTrip>? places;

  Data({this.places});

  Data.fromJson(Map<String, dynamic> json) {
    places = json["places"] == null ? null : (json["places"] as List).map((e) => PlaceTrip.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (places != null) {
      _data["places"] = places?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class PlaceTrip {
  int? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  String? description;
  int? price;
  dynamic rate;
  List<String>? images;
  String? createdAt;
  String? updatedAt;
  double? distance;
  String? note;
  int? visitTime;
  int? startTime;
  int? vehicle;

  PlaceTrip(
      {this.id,
      this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.description,
      this.price,
      this.rate,
      this.images,
      this.createdAt,
      this.updatedAt,
      this.distance,
      this.note,
      this.visitTime,
      this.startTime,
      this.vehicle});

  PlaceTrip.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    address = json["address"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    description = json["description"];
    price = json["price"];
    rate = json["rate"];
    images = json["images"] == null ? null : List<String>.from(json["images"]);
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    distance = json["distance"];
    note = json["note"];
    visitTime = json["visit_time"];
    startTime = json["start_time"];
    vehicle = json["vehicle"];
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
    _data["rate"] = rate;
    if (images != null) {
      _data["images"] = images;
    }
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["distance"] = distance;
    _data["note"] = note;
    _data["visit_time"] = visitTime;
    _data["start_time"] = startTime;
    _data["vehicle"] = vehicle;
    return _data;
  }
}
