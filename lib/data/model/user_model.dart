class UserModel {
  int? code;
  UserData? data;
  String? message;

  UserModel({this.code, this.data, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    data = json["data"] == null ? null : UserData.fromJson(json["data"]);
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

class UserData {
  User? user;
  String? accessToken;

  UserData({this.user, this.accessToken});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    accessToken = json["access_token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["access_token"] = accessToken;
    return _data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? avatar;
  int? gender;
  String? contact;
  String? password;
  bool? isAdmin;
  int? birthDay;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.username, this.email, this.avatar, this.gender, this.contact, this.password, this.isAdmin, this.birthDay, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    email = json["email"];
    avatar = json["avatar"];
    gender = json["gender"];
    contact = json["contact"];
    password = json["password"];
    isAdmin = json["is_admin"];
    birthDay = json["birth_day"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["username"] = username;
    _data["email"] = email;
    _data["avatar"] = avatar;
    _data["gender"] = gender;
    _data["contact"] = contact;
    _data["password"] = password;
    _data["is_admin"] = isAdmin;
    _data["birth_day"] = birthDay;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
