import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/signupcontroller.dart';
import 'package:brew/helper/modedetector.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SignupViews {
  static Container desktopView(
      BuildContext context, FocusNode node, SignupController controller) {
    final double width = (MediaQuery.of(context).size.width * 1);
    return Container(
      color: ModeDetector.isDarkMode(context)
          ? BrewConstants.black87
          : BrewConstants.white,
      child: SafeArea(
        top: false,
        left: false,
        bottom: false,
        right: true,
        minimum: const EdgeInsets.all(1.0),
        child: Scaffold(
          backgroundColor: ModeDetector.isDarkMode(context)
              ? BrewConstants.black87
              : BrewConstants.white,
          body: Center(
            child: Row(
              children: <Widget>[
                width > 767
                    ? Expanded(
                        flex: 2,
                        child: CommonViews.backgroundImage(context),
                      )
                    : Container(),
                signupForm(context, node, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container mobileView(
      BuildContext context, FocusNode node, SignupController controller) {
    return Container(
      color: ModeDetector.isDarkMode(context)
          ? BrewConstants.black87
          : BrewConstants.white,
      child: SafeArea(
        top: false,
        left: false,
        bottom: false,
        right: true,
        minimum: const EdgeInsets.all(1.0),
        child: Scaffold(
          backgroundColor: ModeDetector.isDarkMode(context)
              ? BrewConstants.black87
              : BrewConstants.white,
          body: Center(
            child: Row(
              children: <Widget>[
                signupForm(context, node, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container signupButton(SignupController controller) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: RaisedButton(
        textColor: BrewConstants.white,
        color: BrewConstants.pulseBlue,
        child: Text(BrewConstants.signUp),
        onPressed: () {
          controller.signup();
        },
      ),
    );
  }

  static Container gotoLogin(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            BrewConstants.alreadyAccount,
            style: TextStyle(
                color: ModeDetector.isDarkMode(context)
                    ? BrewConstants.white70
                    : BrewConstants.black87),
          ),
          FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text(BrewConstants.login,
                  style: TextStyle(
                    fontSize: 20,
                    color: BrewConstants.pulseBlue,
                  ))),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  static Expanded signupForm(
      BuildContext context, FocusNode node, SignupController controller) {
    return Expanded(
      flex: 1,
      child: Container(
        // height: 100,
        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
        alignment: Alignment.center,
        child: new Form(
          key: controller.signupFormKey,
          child: ListView(
            children: <Widget>[
              CommonViews.pageTitle(context, BrewConstants.pulse),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.firstNameController,
                  BrewConstants.firstName,
                  false),
              CommonViews.textFieldControl(context, node, controller,
                  controller.lastNameController, BrewConstants.lastName, false),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.displayNameController,
                  BrewConstants.displayName,
                  false),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.emailController,
                  BrewConstants.emailAddress,
                  false),
              CommonViews.textFieldControl(context, node, controller,
                  controller.passwordController, BrewConstants.password, true),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.confirmPasswordController,
                  BrewConstants.confirmPassword,
                  true),
              signupButton(controller),
              GetBuilder<SignupController>(
                init: SignupController(),
                builder: (controller) =>
                    controller.registrationSuccessful.toString() == '0'
                        ? CommonViews.error('User Already Exist')
                        : Container(),
              ),
              gotoLogin(context)
            ],
          ),
        ),
      ),
    );
  }
}
