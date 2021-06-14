import 'package:brew/models/profile/profile.dart';

class ProfileData {
  Profile? data;

  ProfileData({this.data});

  ProfileData.fromJson(Map<String, dynamic> json) {
    this.data = json["data"] == null ? null : Profile.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}
