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

  @override
  void onInit() {
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
}
