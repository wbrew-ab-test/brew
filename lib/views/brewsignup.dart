import 'package:brew/controllers/signupcontroller.dart';
import 'package:brew/helper/platforminfo.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:brew/views/signup/signupview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrewSignup extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    FocusNode node = new FocusNode();
    Get.lazyPut(() => UserAuthService());
    return Scaffold(
        body: PlatformInfo.isWeb()
            ? SignupViews.desktopView(context, node, controller)
            : SignupViews.mobileView(context, node, controller));
  }
}
