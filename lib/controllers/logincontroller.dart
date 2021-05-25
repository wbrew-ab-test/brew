import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/brewauthenticationrequest.dart';
import 'package:brew/models/brewprofile.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxInt loginSuccess = 0.obs;

  @override
  void onInit() {
    nameController.text = '';
    super.onInit();
    // Get.lazyPut(() => UserAuthService());
    ever(loginSuccess, (val) {
      logger.d('loginSuccess : ' + val.toString());
      if (val == 1) {
        Get.toNamed('signup');
      }
    });
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      BrewAuthenticationRequest request = BrewAuthenticationRequest(
          email: nameController.text,
          password: passwordController.text,
          returnSecureToken: true);

      late Future<Response> userProfile =
          Get.find<UserAuthService>().authenticateUser(request, true);

      await userProfile.then((responseObj) {
        logger.d("Status Code : " + responseObj.body.toString());
        if (responseObj.statusCode == 200) {
          BrewProfile obj = BrewProfile.fromJson(responseObj.body);
          loginSuccessChange();
          logger.d('val : ' + loginSuccess.obs.value.toString());
        }
      });
    }
  }

  void loginSuccessChange() {
    logger.d('inside update');
    loginSuccess = 1.obs;
    Get.toNamed('/dashboard');
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
