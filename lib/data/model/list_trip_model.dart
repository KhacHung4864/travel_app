import 'package:travel_app/data/model/places/place_trip_model.dart';

class ListTripModel {
  int? code;
  Data? data;
  String? message;

  ListTripModel({this.code, this.data, this.message});

  ListTripModel.fromJson(Map<String, dynamic> json) {
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
  List<Trips>? trips;

  Data({this.trips});

  Data.fromJson(Map<String, dynamic> json) {
    trips = json["trips"] == null ? null : (json["trips"] as List).map((e) => Trips.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (trips != null) {
      _data["trips"] = trips?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Trips {
  int? id;
  List<DaysTrip>? days;
  String? name;
  int? users;
  int? owner;
  int? fromDate;
  int? toDate;
  int? tripFee;
  String? createdAt;
  String? updatedAt;

  Trips({this.id, this.days, this.name, this.users, this.owner, this.fromDate, this.toDate, this.tripFee, this.createdAt, this.updatedAt});

  Trips.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    days = json["days"] == null ? null : (json["days"] as List).map((e) => DaysTrip.fromJson(e)).toList();
    name = json["name"];
    users = json["users"];
    owner = json["owner"];
    fromDate = json["from_date"];
    toDate = json["to_date"];
    tripFee = json["trip_fee"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if (days != null) {
      _data["days"] = days?.map((e) => e.toJson()).toList();
    }
    _data["name"] = name;
    _data["users"] = users;
    _data["owner"] = owner;
    _data["from_date"] = fromDate;
    _data["to_date"] = toDate;
    _data["trip_fee"] = tripFee;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}

class DaysTrip {
  int? id;
  int? tripId;
  List<PlaceTrip>? places;
  String? createdAt;
  String? updatedAt;

  DaysTrip({this.id, this.tripId, this.places, this.createdAt, this.updatedAt});

  DaysTrip.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tripId = json["trip_id"];
    places = json["places"] == null ? null : (json["places"] as List).map((e) => PlaceTrip.fromJson(e)).toList();
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["trip_id"] = tripId;
    if (places != null) {
      _data["places"] = places?.map((e) => e.toJson()).toList();
    }
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
