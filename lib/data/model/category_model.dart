class CategoryModel {
  int? code;
  Data? data;
  String? message;

  CategoryModel({this.code, this.data, this.message});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
  List<Categories>? categories;

  Data({this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    categories = json["categories"] == null ? null : (json["categories"] as List).map((e) => Categories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (categories != null) {
      _data["categories"] = categories?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Categories {
  int? id;
  String? name;
  String? description;
  String? icon;
  dynamic places;
  String? createdAt;
  String? updatedAt;

  Categories({this.id, this.name, this.description, this.icon, this.places, this.createdAt, this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    icon = json["icon"];
    places = json["Places"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["icon"] = icon;
    _data["Places"] = places;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
