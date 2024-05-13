class BaseModel {
  int? code;
  Data? data;
  String? message;

  BaseModel({this.code, this.data, this.message});

  BaseModel.fromJson(Map<String, dynamic> json) {
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
  String? file;

  Data({this.file});

  Data.fromJson(Map<String, dynamic> json) {
    file = json["file"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["file"] = file;
    return _data;
  }
}
