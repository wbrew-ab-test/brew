import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/signupmentorcontroller.dart';
import 'package:brew/helper/modedetector.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class SignupMentorViews {
  static Container desktopView(BuildContext context, FocusNode node) {
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
                signupForm(context, node),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container mobileView(BuildContext context, FocusNode node) {
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
                signupForm(context, node),
                // signupForm(context, node, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Expanded signupForm(BuildContext context, FocusNode node) {
    SignupMentorController controller = new SignupMentorController();
    return Expanded(
      flex: 1,
      child: Container(
        // height: 100,
        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
        alignment: Alignment.center,
        child: new Form(
          key: controller.signupMentorFormKey,
          child: ListView(
            children: <Widget>[
              CommonViews.pageTitle(context, BrewConstants.pulse),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.mentorFirstNameController,
                  BrewConstants.firstName,
                  false,
                  true),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.mentorLastNameController,
                  BrewConstants.lastName,
                  false,
                  true),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.mentorDisplayNameController,
                  BrewConstants.displayName,
                  false,
                  true),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.mentorEmailController,
                  BrewConstants.emailAddress,
                  false,
                  true),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.mentorPasswordController,
                  BrewConstants.password,
                  true,
                  true),
              CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.mentorConfirmPasswordController,
                  BrewConstants.confirmPassword,
                  true,
                  true),
              CommonViews.brewDropdown(),
              signupButton(controller),
              // signupButton(controller),
              GetBuilder<SignupMentorController>(
                init: SignupMentorController(),
                builder: (controller) =>
                    controller.registrationSuccessful.toString() == '0'
                        ? CommonViews.error('User Already Exist')
                        : Container(),
              ),
              gotoLogin(context),
            ],
          ),
        ),
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
                // Get.to(BrewLogin());
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

  static Container signupButton(SignupMentorController controller) {
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
}
