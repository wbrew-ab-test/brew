import 'package:brew/helper/platforminfo.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:brew/views/signup/signupmentorview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// class BrewMentorSignup extends GetView<SignupMentorController> {
class BrewMentorSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode node = new FocusNode();
    Get.lazyPut(() => UserAuthService());
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Pulse - Mentor Sign up',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      body: PlatformInfo.isWeb()
          ? SignupMentorViews.desktopView(context, node)
          : SignupMentorViews.mobileView(context, node),
    );
  }
}
