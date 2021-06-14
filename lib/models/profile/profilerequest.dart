class ProfileRequest {
  String? email;

  ProfileRequest({this.email});

  ProfileRequest.fromJson(Map<String, dynamic> json) {
    this.email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["email"] = this.email;
    return data;
  }
}
