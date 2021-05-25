class UserSignupRequest {
  final String displayName;
  final String? localId;
  final String? photoUrl;
  final String? captchaResponse;
  final String? idToken;
  final String? tenantProjectNumber;
  final String? tenantId;
  final bool? disabled;
  final String? instanceId;
  final String? phoneNumber;
  final bool? emailVerified;
  final String? captchaChallenge;
  final String password;
  final String email;

  UserSignupRequest({
    required this.displayName,
    this.localId,
    this.photoUrl,
    this.captchaResponse,
    this.idToken,
    this.tenantProjectNumber,
    this.tenantId,
    this.disabled,
    this.instanceId,
    this.phoneNumber,
    this.emailVerified,
    this.captchaChallenge,
    required this.password,
    required this.email,
  });

  factory UserSignupRequest.fromJson(Map<String, dynamic> json) =>
      UserSignupRequest(
        displayName: json["displayName"],
        localId: json["localId"],
        photoUrl: json["photoUrl"],
        captchaResponse: json["captchaResponse"],
        idToken: json["idToken"],
        tenantProjectNumber: json["tenantProjectNumber"],
        tenantId: json["tenantId"],
        disabled: json["disabled"],
        instanceId: json["instanceId"],
        phoneNumber: json["phoneNumber"],
        emailVerified: json["emailVerified"],
        captchaChallenge: json["captchaChallenge"],
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "localId": localId,
        "photoUrl": photoUrl,
        "captchaResponse": captchaResponse,
        "idToken": idToken,
        "tenantProjectNumber": tenantProjectNumber,
        "tenantId": tenantId,
        "disabled": disabled,
        "instanceId": instanceId,
        "phoneNumber": phoneNumber,
        "emailVerified": emailVerified,
        "captchaChallenge": captchaChallenge,
        "password": password,
        "email": email,
      };
}
