import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/profile/profile.dart';
import 'package:brew/models/profile/profilerequest.dart';
import 'package:brew/models/usersignuprequest.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupMentorController extends GetxController {
  GlobalKey<FormState> signupMentorFormKey = GlobalKey<FormState>();
  TextEditingController mentorDisplayNameController = TextEditingController();
  TextEditingController mentorFirstNameController = TextEditingController();
  TextEditingController mentorLastNameController = TextEditingController();
  TextEditingController mentorEmailController = TextEditingController();
  TextEditingController mentorPasswordController = TextEditingController();
  TextEditingController mentorConfirmPasswordController =
      TextEditingController();
  String? selectedValue = 'Level 1 : Experience (0-3)';

  List<String> experience = <String>[
    'Level 1 : Experience (0-3)',
    'Level 2 : Experience (3-5)',
    'Level 2 : Experience (5+)'
  ];

  RxInt registrationSuccessful = 1.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  void onSelected(String value) {
    selectedValue = value;
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void signup() async {
    if (signupMentorFormKey.currentState!.validate()) {
      logger.d('sign up form');
      UserSignupRequest request = new UserSignupRequest(
          displayName: mentorDisplayNameController.text,
          password: mentorPasswordController.text,
          email: mentorEmailController.text);

      late Future<Response> registerationResponse =
          Get.find<UserAuthService>().registerUser(request);
      await registerationResponse.then((response) {
        logger.d("Status Code : " + response.body.toString());

        if (response.statusCode == 200 || response.statusCode == 201) {
          logger.i('Successful registration.');

          Profile userProfile = new Profile(
              email: mentorEmailController.text,
              firstName: mentorFirstNameController.text,
              lastName: mentorLastNameController.text,
              displayName: mentorDisplayNameController.text,
              persona: 'mentor');
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
    mentorDisplayNameController.dispose();
    mentorFirstNameController.dispose();
    mentorLastNameController.dispose();
    mentorEmailController.dispose();
    mentorPasswordController.dispose();
    mentorConfirmPasswordController.dispose();
    super.onClose();
  }
}
