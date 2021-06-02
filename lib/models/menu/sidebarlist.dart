import 'package:brew/models/menu/sidebar.dart';

class SidebarList {
  List<Sidebarnav> sidebarnav;
  SidebarList({
    required this.sidebarnav,
  });

  factory SidebarList.fromJson(Map<String, dynamic> json) => SidebarList(
        sidebarnav: List<Sidebarnav>.from(
            json['sidebarnav'].map((x) => Sidebarnav.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'sidebarnav': List<dynamic>.from(sidebarnav.map((x) => x.toJson())),
      };
}
