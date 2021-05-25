class BrewProfile {
  String kind;
  String localId;
  String email;
  String displayName;
  String idToken;
  bool registered;
  String? profilePicture;
  String refreshToken;
  String expiresIn;

  BrewProfile(
      {required this.kind,
      required this.localId,
      required this.email,
      required this.displayName,
      required this.idToken,
      required this.registered,
      this.profilePicture,
      required this.refreshToken,
      required this.expiresIn});

  factory BrewProfile.fromJson(Map<String, dynamic> json) => BrewProfile(
      kind: json["kind"],
      localId: json["localId"],
      email: json["email"],
      displayName: json["displayName"],
      idToken: json["idToken"],
      registered: json["registered"],
      profilePicture: json["profilePicture"],
      refreshToken: json["refreshToken"],
      expiresIn: json["expiresIn"]);

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "localId": localId,
        "email": email,
        "displayName": displayName,
        "idToken": idToken,
        "registered": registered,
        "profilePicture": profilePicture,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn
      };
}
