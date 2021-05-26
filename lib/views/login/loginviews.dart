import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/logincontroller.dart';
import 'package:brew/helper/modedetector.dart';
import 'package:brew/helper/platforminfo.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class LoginViews {
  static Scaffold desktopView(
      BuildContext context, LoginController controller, FocusNode node) {
    final double width = (MediaQuery.of(context).size.width * 1);
    logger.d('Width : ' + width.toString());

    return Scaffold(
      body: Container(
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
                  loginForm(controller, context, node),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Scaffold mobileView(
      BuildContext context, LoginController controller, FocusNode node) {
    logger.d('Loading Mobile view');
    return Scaffold(
      body: Container(
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
                  GetBuilder<LoginController>(
                    init: LoginController(),
                    builder: (controller) =>
                        loginForm(controller, context, node),
                  ),
                  // loginForm(controller, context, node),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container loginTitle() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        BrewConstants.pulse,
        style: TextStyle(
          color: BrewConstants.pulseBlue,
          fontWeight: FontWeight.w800,
          fontSize: 60,
        ),
      ),
    );
  }

  static Container loginButton(
      BuildContext context, LoginController controller) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: RaisedButton(
        textColor: BrewConstants.white70,
        color: BrewConstants.pulseBlue,
        child: Text(BrewConstants.login),
        onPressed: () {
          controller.login();
        },
      ),
    );
  }

  static Container forgotPassword() {
    return Container(
      child: FlatButton(
        onPressed: () {
          //forgot password screen
        },
        textColor: BrewConstants.pulseBlue,
        child: Text(BrewConstants.forgotPassword),
      ),
    );
  }

  static Container signupContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        children: <Widget>[
          Text(
            BrewConstants.doYouHaveAccount,
            style: TextStyle(
                color: ModeDetector.isDarkMode(context)
                    ? BrewConstants.white70
                    : BrewConstants.black87),
          ),
          FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.toNamed('/signup');
            },
            child: Padding(
              padding: EdgeInsets.zero,
              child: Text(
                BrewConstants.signIn,
                style: TextStyle(
                  fontSize: 18,
                  color: BrewConstants.pulseBlue,
                ),
              ),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  static Expanded loginForm(
      LoginController controller, BuildContext context, FocusNode node) {
    return Expanded(
      flex: 1,
      child: Container(
          // height: 100,
          padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
          alignment: Alignment.center,
          child: new Form(
            key: controller.loginFormKey,
            child: ListView(
              children: <Widget>[
                CommonViews.pageTitle(context, BrewConstants.pulse),
                CommonViews.textFieldControl(context, node, controller,
                    controller.nameController, BrewConstants.userName, false),
                CommonViews.textFieldControl(
                    context,
                    node,
                    controller,
                    controller.passwordController,
                    BrewConstants.password,
                    true),
                nonDesktopView(controller, context),
                loginButton(context, controller),
                forgotPassword(),
                signupContainer(context),
              ],
            ),
          )),
    );
  }

  static dynamic nonDesktopView(
      LoginController controller, BuildContext context) {
    return controller.isFaceID && !PlatformInfo.isWeb()
        ? InkWell(
            onTap: () => controller.authenticate(controller.nameController.text,
                controller.passwordController.text, controller.isFaceID),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.transparent, width: 2.0),
                  // borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(10.0),
                // child: Image.asset("assets/faceid.png"),
                child: PlatformInfo.isAndroid()
                    ? Icon(
                        FontAwesomeIcons.fingerprint,
                        color: ModeDetector.isDarkMode(context)
                            ? BrewConstants.white70
                            : BrewConstants.black54,
                      )
                    : Text(
                        BrewConstants.enabledFaceId,
                        style: TextStyle(
                          color: BrewConstants.indigo,
                        ),
                        textAlign: TextAlign.center,
                      )),
          )
        : !controller.isFaceID && !PlatformInfo.isWeb()
            ? InkWell(
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor:
                                ModeDetector.isDarkMode(context)
                                    ? BrewConstants.darkCheckboxTick
                                    : BrewConstants.lightCheckboxTick,
                          ),
                          child: Checkbox(
                              value: controller.isFaceID,
                              onChanged: (v) {
                                logger.d('v : ' + v.toString());
                                var val = controller.isFaceID;
                                controller.isFaceID = !val;
                                controller.update();
                              }),
                        ),
                        Text(
                          BrewConstants.enableFaceId,
                          style: TextStyle(
                            color: BrewConstants.indigo,
                          ),
                        ),
                      ]),
                ),
              )
            : InkWell(child: Container());
  }
}
