import 'package:brew/models/menu/sidebarlist.dart';

class MenuResponse {
  List<SidebarList> data;
  MenuResponse({
    required this.data,
  });

  factory MenuResponse.fromJson(Map<String, dynamic> json) => MenuResponse(
        data: List<SidebarList>.from(
            json["data"].map((x) => SidebarList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
