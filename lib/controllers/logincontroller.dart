
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/services/brewloginservice.dart';
import 'package:brew/services/loginservice.dart';
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
    Get.lazyPut(()=>LoginService());
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

  void login() {
    if (loginFormKey.currentState!.validate()) {
      BrewLoginService.signInWeb(nameController.text, passwordController.text);
      logger.d('val : ' + loginSuccess.obs.value.toString());
    }
  }

  void loginSuccessChange() {
    logger.d('inside update');
    loginSuccess = 1.obs;
    Get.toNamed('/signup');
    update();
  }


  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}