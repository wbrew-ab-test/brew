import 'package:brew/constants/brewconstants.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/page/pagerequest.dart';
import 'package:brew/models/page/pageresponse.dart';
import 'package:brew/models/profile/profile.dart';
import 'package:brew/models/usersignuprequest.dart';
import 'package:brew/services/pageloadservice.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static late GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxInt registrationSuccessful = 1.obs;
  late Worker _ever;
  PageResponse? pageResponse;
  String? sideBarPath;
  int? length;
  String? title;

  @override
  void onInit() async {
    super.onInit();
    displayNameController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    Get.lazyPut(() => PageloadService());
    PageRequest request = new PageRequest(collectionName: 'brewstudentsignup');
    late Future<Response> pageResponse = Get.find<PageloadService>()
        .fetchPage(BrewConstants.fetchPageUrl, request);
    logger.d('pageResponse : ' + pageResponse.toString());

    // await pageResponse.then((page) {
    //   logger.d('page :' + page.body.toString());
    // });
    await pageResponse.then((response) {
      logger.d('Sign up Response: ' + response.body.toString());
      this.pageResponse = PageResponse.fromJson(response.body);
      logger.d(
          'Sign up pageResponse : ' + this.pageResponse!.data!.collectionName!);

      this.sideBarPath = (this
          .pageResponse!
          .data!
          .controls!
          .firstWhere((control) => (control.type == 'sidebar'))
          .imageurl);

      if (null != this.pageResponse &&
          null != this.pageResponse!.data &&
          null != this.pageResponse!.data!.controls) {
        this.length = this.pageResponse!.data!.controls!.length + 1;
      }
    });

    _ever = ever(
        registrationSuccessful, (_) => logger.d("$_ has been changed (ever)"));
    update();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void signup(Controls control) async {
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
