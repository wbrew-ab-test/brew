
import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/logincontroller.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/services/loginservice.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


Future<BrewProfile> validateOrRegisterUser(
    BrewAuthenticationRequest request, bool isSignIn) async {
  Map<String, String> requestHeaders = {"Content-type": "application/json"};
  final String json = jsonEncode(request);
  logger.i('request: ' + json);
  final url = Uri.parse(isSignIn
      ? (BrewConstants.loginUrl + BrewConstants.httpKey)
      : (BrewConstants.signUpUrl + BrewConstants.httpKey));
  final response = await http.post(url, headers: requestHeaders, body: json);

  logger.d('TimelineAuthentication validateOrRegisterUser Status Code : ' +
      response.statusCode.toString());

  if (response.statusCode == 200) {
    return BrewProfile.fromJson(
        jsonDecode(response.body));
  } else {
    logger.d('TimelineAuthentication validateOrRegisterUser Response : ' +
        response.toString());
    throw Exception('Failed to load album.');
  }
}

class BrewLoginService extends GetxService{

  static signInWeb(String username, String password) async {
    BrewAuthenticationRequest request = BrewAuthenticationRequest(
        email: username,
        password: password,
        returnSecureToken: true);

    late Future<Response> userProfile = Get.find<LoginService>()
        .authenticateUser(request, true);

    await userProfile.then((responseObj) {
      logger.d("Status Code : " + responseObj.body.toString());
      if (responseObj.statusCode == 200) {
        BrewProfile obj = BrewProfile.fromJson(responseObj.body);
        Get.find<LoginController>().loginSuccessChange();
      }
    });
  }
}

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

class BrewProfile {
  String kind;
  String localId;
  String email;
  String displayName;
  String idToken;
  bool registered;
  String profilePicture;
  String refreshToken;
  String expiresIn;

  BrewProfile({
    required this.kind,
    required this.localId,
    required this.email,
    required this.displayName,
    required this.idToken,
    required this.registered,
    required this.profilePicture,
    required this.refreshToken,
    required this.expiresIn
  });

  factory BrewProfile.fromJson(Map<String, dynamic> json) => BrewProfile(
    kind: json["kind"],
    localId: json["localId"],
    email: json["email"],
    displayName: json["displayName"],
    idToken: json["idToken"],
    registered: json["registered"],
    profilePicture: json["profilePicture"],
    refreshToken: json["refreshToken"],
    expiresIn: json["expiresIn"]
  );

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
