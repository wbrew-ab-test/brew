class PageRequest {
  String? collectionName;

  PageRequest({this.collectionName});

  PageRequest.fromJson(Map<String, dynamic> json) {
    this.collectionName = json["collectionName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["collectionName"] = this.collectionName;
    return data;
  }
}
