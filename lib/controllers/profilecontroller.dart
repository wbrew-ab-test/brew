import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/profile/profile.dart';
import 'package:brew/models/profile/profiledata.dart';
import 'package:brew/models/profile/profilerequest.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  static late GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  ProfileData? profile;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool isEnabled = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController enrolledController = TextEditingController();
  TextEditingController desiredBandController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    final SharedPreferences prefs = await _prefs;
    final String? email = prefs.getString('email');
    logger.d('email : ' + email!);
    if (null != email) {
      ProfileRequest request = new ProfileRequest(email: email);
      late Future<Response> profileResponse =
          Get.find<UserAuthService>().getProfile(request);
      await profileResponse.then((response) {
        // profile = new Profile();
        profile = ProfileData.fromJson(response.body);
        logger.d('response : ' + profile!.data!.firstName!);
        firstNameController.text = profile!.data!.firstName!;
        lastNameController.text = profile!.data!.lastName!;
        emailController.text = profile!.data!.email!;
        displayNameController.text = profile!.data!.displayName!;
        if (null != profile!.data!.persona &&
            profile!.data!.persona == 'student') {
          desiredBandController.text = null != profile!.data!.desiredBand &&
                  profile!.data!.desiredBand!.trim() != ''
              ? profile!.data!.desiredBand!
              : 'Not Confirmed';

          enrolledController.text = null != profile!.data!.enrolledPlan &&
                  profile!.data!.enrolledPlan!.trim() != ''
              ? profile!.data!.enrolledPlan!
              : 'Not Confirmed';
        }
        update();
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void setEnabled(bool isEnabled) {
    this.isEnabled = isEnabled;
  }

  void applyUpdate() {
    update();
  }
}
