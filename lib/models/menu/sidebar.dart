class Sidebarnav {
  String navId;
  String displayName;
  Sidebarnav({
    required this.navId,
    required this.displayName,
  });

  factory Sidebarnav.fromJson(Map<String, dynamic> json) => Sidebarnav(
        navId: json['navId'],
        displayName: json['displayName'],
      );

  Map<String, dynamic> toJson() => {
        'navId': navId,
        'displayName': displayName,
      };
}
