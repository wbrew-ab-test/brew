import 'package:brew/helper/platforminfo.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:brew/views/login/loginviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// class BrewLogin extends GetView<LoginController> {
class BrewLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    logger.d(
        '************************ Inside the BrewLogin *************************');
    FocusNode node = new FocusNode();
    Get.lazyPut(() => UserAuthService());

    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Pulse - Login',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return PlatformInfo.isWeb()
        ? LoginViews.desktopView(context, node)
        : LoginViews.mobileView(context, node);
  }
}
