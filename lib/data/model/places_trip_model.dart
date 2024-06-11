class PlaceTrip {
  int? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  String? description;
  int? price;
  int? rate;
  List<Categories>? categories;
  List<String>? images;
  String? createdAt;
  String? updatedAt;

  PlaceTrip({this.id, this.name, this.address, this.latitude, this.longitude, this.description, this.price, this.rate, this.categories, this.images, this.createdAt, this.updatedAt});

  PlaceTrip.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    address = json["address"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    description = json["description"];
    price = json["price"];
    rate = json["rate"];
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
    _data["rate"] = rate;
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

class Categories {
  int? id;
  String? name;
  String? description;
  String? icon;
  String? createdAt;
  String? updatedAt;

  Categories({this.id, this.name, this.description, this.icon, this.createdAt, this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    icon = json["icon"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["icon"] = icon;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
