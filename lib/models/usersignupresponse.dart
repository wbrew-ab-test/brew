class UserSignupResponse {
  final String expiresIn;
  final String kind;
  final String displayName;
  final String localId;
  final String idToken;
  final String refreshToken;
  final String email;

  UserSignupResponse({
    required this.expiresIn,
    required this.kind,
    required this.displayName,
    required this.localId,
    required this.idToken,
    required this.refreshToken,
    required this.email,
  });

  factory UserSignupResponse.fromJson(Map<String, dynamic> json) =>
      UserSignupResponse(
        expiresIn: json["expiresIn"],
        kind: json["kind"],
        displayName: json["displayName"],
        localId: json["localId"],
        idToken: json["idToken"],
        refreshToken: json["refreshToken"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "expiresIn": expiresIn,
        "kind": kind,
        "displayName": displayName,
        "localId": localId,
        "idToken": idToken,
        "refreshToken": refreshToken,
        "email": email,
      };
}
