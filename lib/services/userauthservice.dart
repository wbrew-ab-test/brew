import 'package:brew/constants/brewconstants.dart';
import 'package:brew/models/brewauthenticationrequest.dart';
import 'package:brew/models/profile/profile.dart';
import 'package:brew/models/profile/profilerequest.dart';
import 'package:brew/models/usersignuprequest.dart';
import 'package:get/get.dart';
import 'dart:convert';

class UserAuthService extends GetConnect {
  Future<Response> authenticateUser(
      BrewAuthenticationRequest request, bool isSignIn) {
    final String json = jsonEncode(request);
    final url = Uri.parse(isSignIn
        ? (BrewConstants.loginUrl + BrewConstants.httpKey)
        : (BrewConstants.signUpUrl + BrewConstants.httpKey));
    return post(url.toString(), json, contentType: "application/json");
  }

  Future<Response> registerUser(UserSignupRequest request) {
    final String json = jsonEncode(request);
    final url = Uri.parse(BrewConstants.signUpUrl + BrewConstants.httpKey);
    return post(url.toString(), json, contentType: "application/json");
  }

  Future<Response> registerUserInsideBrew(Profile request) {
    final String json = jsonEncode(request);
    final url = Uri.parse(BrewConstants.signBrewUpUrl);
    return post(url.toString(), json, contentType: "application/json");
  }

  Future<Response> getProfile(ProfileRequest request) {
    final String json = jsonEncode(request);
    final url = Uri.parse(BrewConstants.profileUserByIdUrl);
    return post(url.toString(), json, contentType: "application/json");
  }
}
