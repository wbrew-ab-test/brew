

import 'package:brew/constants/brewconstants.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/services/brewloginservice.dart';
import 'package:get/get.dart';
import 'dart:convert';

class LoginService extends GetConnect {
  Future<Response> authenticateUser(
      BrewAuthenticationRequest request, bool isSignIn) {
    final String json = jsonEncode(request);
    final url = Uri.parse(isSignIn
        ? (BrewConstants.loginUrl + BrewConstants.httpKey)
        : (BrewConstants.signUpUrl + BrewConstants.httpKey));
    return post(url.toString(), json, contentType: "application/json");

    // if (null != response.statusCode && response.statusCode == 200) {
    //   logger.d("LoginService : response : " + response.body.toString());
    //
    //   Map<String, dynamic> bodyObj = jsonDecode(response.body);
    //   logger.d("bodyobj : " + bodyObj.toString());
    //   return BrewProfile.fromJson(jsonDecode(response.body));
    // } else {
    //   logger.d('TimelineAuthentication validateOrRegisterUser Response : ' +
    //       response.toString());
    //   throw Exception('Failed to load album.');
    // }
  }
}