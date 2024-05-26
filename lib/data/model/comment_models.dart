class CommentModel {
  int? code;
  Data? data;
  String? message;

  CommentModel({this.code, this.data, this.message});

  CommentModel.fromJson(Map<String, dynamic> json) {
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
  List<Comments>? comments;
  int? page;
  int? perPage;
  int? totalPage;
  int? totalRecord;

  Data({this.comments, this.page, this.perPage, this.totalPage, this.totalRecord});

  Data.fromJson(Map<String, dynamic> json) {
    comments = json["comments"] == null ? null : (json["comments"] as List).map((e) => Comments.fromJson(e)).toList();
    page = json["page"];
    perPage = json["per_page"];
    totalPage = json["total_page"];
    totalRecord = json["total_record"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (comments != null) {
      _data["comments"] = comments?.map((e) => e.toJson()).toList();
    }
    _data["page"] = page;
    _data["per_page"] = perPage;
    _data["total_page"] = totalPage;
    _data["total_record"] = totalRecord;
    return _data;
  }
}

class Comments {
  int? id;
  int? rate;
  String? comment;
  int? userId;
  User? user;
  int? placeId;
  Place? place;
  String? createdAt;
  String? updatedAt;

  Comments({this.id, this.rate, this.comment, this.userId, this.user, this.placeId, this.place, this.createdAt, this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    rate = json["rate"];
    comment = json["comment"];
    userId = json["user_id"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    placeId = json["place_id"];
    place = json["place"] == null ? null : Place.fromJson(json["place"]);
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["rate"] = rate;
    _data["comment"] = comment;
    _data["user_id"] = userId;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["place_id"] = placeId;
    if (place != null) {
      _data["place"] = place?.toJson();
    }
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}

class Place {
  int? id;

  Place({this.id});

  Place.fromJson(Map<String, dynamic> json) {
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    return _data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  bool? active;
  String? avatar;
  int? gender;
  String? contact;
  String? password;
  bool? isAdmin;
  int? birthDay;
  dynamic trips;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.username, this.email, this.active, this.avatar, this.gender, this.contact, this.password, this.isAdmin, this.birthDay, this.trips, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    email = json["email"];
    active = json["active"];
    avatar = json["avatar"];
    gender = json["gender"];
    contact = json["contact"];
    password = json["password"];
    isAdmin = json["is_admin"];
    birthDay = json["birth_day"];
    trips = json["Trips"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["username"] = username;
    _data["email"] = email;
    _data["active"] = active;
    _data["avatar"] = avatar;
    _data["gender"] = gender;
    _data["contact"] = contact;
    _data["password"] = password;
    _data["is_admin"] = isAdmin;
    _data["birth_day"] = birthDay;
    _data["Trips"] = trips;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
