import 'package:brew/controllers/logincontroller.dart';
import 'package:brew/helper/platforminfo.dart';
import 'package:brew/views/login/loginviews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrewLogin extends GetView<LoginController> {

  @override
  Widget build(BuildContext context) {
    FocusNode node = new FocusNode();
    return Scaffold(
      body: PlatformInfo.isWeb()
          ? LoginViews.desktopView(context,controller, node)
          : Text('Mobile')
    );
  }
}