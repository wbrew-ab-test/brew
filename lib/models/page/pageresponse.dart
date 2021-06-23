class PageResponse {
  Data? data;

  PageResponse({this.data});

  PageResponse.fromJson(Map<String, dynamic> json) {
    this.data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}

class Data {
  List<Controls>? controls;
  String? screenName;
  String? collectionName;
  String? titleOfPage;
  String? webPageTitle;

  Data(
      {this.controls,
      this.screenName,
      this.collectionName,
      this.titleOfPage,
      this.webPageTitle});

  Data.fromJson(Map<String, dynamic> json) {
    this.controls = json["controls"] == null
        ? null
        : (json["controls"] as List).map((e) => Controls.fromJson(e)).toList();
    this.screenName = json["screenName"];
    this.collectionName = json["collectionName"];
    this.titleOfPage = json["titleOfPage"];
    this.webPageTitle = json["webPageTitle"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.controls != null)
      data["controls"] = this.controls?.map((e) => e.toJson()).toList();
    data["screenName"] = this.screenName;
    data["collectionName"] = this.collectionName;
    data["titleOfPage"] = this.titleOfPage;
    data["webPageTitle"] = this.webPageTitle;
    return data;
  }
}

class Controls {
  bool? isSecure;
  String? label;
  String? type;
  String? imageurl;
  String? name;
  int? seq;
  String? route;
  bool? isEnable;

  Controls(
      {this.isSecure,
      this.label,
      this.type,
      this.imageurl,
      this.name,
      this.seq,
      this.route,
      this.isEnable});

  Controls.fromJson(Map<String, dynamic> json) {
    this.isSecure = json["isSecure"];
    this.label = json["label"];
    this.type = json["type"];
    this.imageurl = json["imageurl"];
    this.name = json["name"];
    this.seq = json["seq"];
    this.route = json["route"];
    this.isEnable = json["isEnable"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["isSecure"] = this.isSecure;
    data["label"] = this.label;
    data["type"] = this.type;
    data["imageurl"] = this.imageurl;
    data["name"] = this.name;
    data["seq"] = this.seq;
    data["route"] = this.route;
    data["isEnable"] = this.isEnable;
    return data;
  }
}
