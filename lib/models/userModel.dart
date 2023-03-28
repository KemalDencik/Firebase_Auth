class UserModel {
  String? telefon;
  String? isim;
  String? email;
  String? token;
  String? userId;
  bool? photo;

  UserModel({this.telefon, this.isim, this.email, this.token, this.userId});
  UserModel.fromJson(Map<String, dynamic> json) {
    telefon = json["telefon"];
    isim = json["isim"];
    email = json["email"];
    token = json["token"];
    userId = json["userId"];
    photo = json["photo"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["telefon"] = telefon;
    data["isim"] = isim;
    data["email"] = email;
    data["token"] = token;
    data["userId"] = userId;
    data["photo"] = photo;
    return data;
  }
}
