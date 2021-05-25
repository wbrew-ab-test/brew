class BrewAuthenticationRequest {
  final String email;
  final String password;
  final bool returnSecureToken;

  BrewAuthenticationRequest(
      {required this.email,
      required this.password,
      required this.returnSecureToken});

  Map<String, dynamic> toJson() => {
        'email': this.email,
        'password': this.password,
        'returnSecureToken': this.returnSecureToken,
      };
}
