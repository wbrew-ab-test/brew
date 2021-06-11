import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/profile/profile.dart';
import 'package:brew/models/usersignuprequest.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxInt registrationSuccessful = 1.obs;
  late Worker _ever;

  @override
  void onInit() {
    super.onInit();
    displayNameController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    // Get.lazyPut(() => BrewSignupService());
    // Get.lazyPut(() => UserAuthService());

    _ever = ever(
        registrationSuccessful, (_) => logger.d("$_ has been changed (ever)"));
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void signup() async {
    if (signupFormKey.currentState!.validate()) {
      logger.d('sign up form');
      UserSignupRequest request = new UserSignupRequest(
          displayName: displayNameController.text,
          password: passwordController.text,
          email: emailController.text);

      late Future<Response> registerationResponse =
          Get.find<UserAuthService>().registerUser(request);
      await registerationResponse.then((response) {
        logger.d("Status Code : " + response.body.toString());

        if (response.statusCode == 200 || response.statusCode == 201) {
          logger.i('Successful registration.');

          Profile userProfile = new Profile(
              email: emailController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              displayName: displayNameController.text,
              persona: 'student');
          logger.d('profile : ' + userProfile.toString());
          late Future<Response> profileOject =
              Get.find<UserAuthService>().registerUserInsideBrew(userProfile);
          profileOject.then((profileResponse) {
            logger.d('profileResponse : ' + profileResponse.body.toString());
            setRegistrationSuccessful();
            logger.d('setRegistrationSuccessful');
            update([setRegistrationSuccessful], true);
            Get.back();
          });
        } else if (response.statusCode == 400) {
          logger.d("BAD REQUEST");
          this.registrationSuccessful = 0.obs;
          // loginSuccess = 0.obs;
          update();
        } else {
          logger.d("response.statusCode : " + response.body.toString());
          this.registrationSuccessful = 0.obs;
        }
      });
    }
  }

  void setRegistrationSuccessful() {
    registrationSuccessful = 1.obs;
  }

  @override
  void onClose() {
    displayNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
    _ever.dispose();
  }
}
