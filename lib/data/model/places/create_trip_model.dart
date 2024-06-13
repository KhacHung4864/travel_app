class CreateTripModel {
  int? owner;
  String? name;
  int? fromDate;
  int? toDate;
  int? users;
  List<Days>? days;

  CreateTripModel({this.owner, this.name, this.fromDate, this.toDate, this.users, this.days});

  CreateTripModel.fromJson(Map<String, dynamic> json) {
    owner = json["owner"];
    name = json["name"];
    fromDate = json["from_date"];
    toDate = json["to_date"];
    users = json["users"];
    days = json["days"] == null ? null : (json["days"] as List).map((e) => Days.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["owner"] = owner;
    _data["name"] = name;
    _data["from_date"] = fromDate;
    _data["to_date"] = toDate;
    _data["users"] = users;
    if (days != null) {
      _data["days"] = days?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Days {
  List<CrPlaceTrip>? places;

  Days({this.places});

  Days.fromJson(Map<String, dynamic> json) {
    places = json["places"] == null ? null : (json["places"] as List).map((e) => CrPlaceTrip.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (places != null) {
      _data["places"] = places?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class CrPlaceTrip {
  int? id;
  String? note;
  int? visitTime;
  int? startTime;
  int? vehicle;

  CrPlaceTrip({this.id, this.note, this.visitTime, this.startTime, this.vehicle});

  CrPlaceTrip.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    note = json["note"];
    visitTime = json["visit_time"];
    startTime = json["start_time"];
    vehicle = json["vehicle"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["note"] = note;
    _data["visit_time"] = visitTime;
    _data["start_time"] = startTime;
    _data["vehicle"] = vehicle;
    return _data;
  }
}
