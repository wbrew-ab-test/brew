import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/logincontroller.dart';
import 'package:brew/helper/modedetector.dart';
import 'package:brew/helper/platforminfo.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/page/pageresponse.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginViews {
  static Scaffold desktopView(BuildContext context, FocusNode node) {
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
                      ? GetBuilder<LoginController>(
                          init: LoginController(),
                          builder: (controller) => Expanded(
                            flex: 2,
                            child: (null != controller.sideBarPath)
                                ? CommonViews.loadBackgroundImage(
                                    controller.sideBarPath, context)
                                : Container(),
                          ),
                        )
                      : Container(),
                  GetBuilder<LoginController>(
                    init: LoginController(),
                    builder: (controller) =>
                        loginForm(controller, context, node),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Scaffold mobileView(BuildContext context, FocusNode node) {
    logger.d('Loading Mobile view');
    // LoginController controller = new LoginController();
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
      BuildContext context, LoginController controller, Controls control) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: RaisedButton(
        textColor: BrewConstants.white70,
        color: BrewConstants.pulseBlue,
        child: Text(control.name!),
        onPressed: () {
          controller.login(control);
        },
      ),
    );
  }

  static Container forgotPassword(Controls control) {
    return Container(
      child: FlatButton(
        onPressed: () {
          //forgot password screen
        },
        textColor: BrewConstants.pulseBlue,
        child: Text(control.label!),
      ),
    );
  }

  static Container signupContainer(
      BuildContext context, Controls studentControl, Controls mentorControl) {
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
          // CommonViews.buttonRoute(BrewConstants.student, '/signup', 14),
          CommonViews.buttonRoute(
              studentControl.label!, studentControl.route!, 14),
          Text(
            BrewConstants.or,
            style: TextStyle(
                color: ModeDetector.isDarkMode(context)
                    ? BrewConstants.white70
                    : BrewConstants.black87),
          ),
          // CommonViews.buttonRoute(BrewConstants.mentor, '/mentorSignup', 14),
          CommonViews.buttonRoute(
              mentorControl.label!, mentorControl.route!, 14),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  static Expanded loginForm(
      LoginController controller, BuildContext context, FocusNode node) {
    // LoginController controller = new LoginController();
    return Expanded(
      flex: 1,
      child: Container(
        // height: 100,
        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
        alignment: Alignment.center,
        child: new Form(
          key: LoginController.loginFormKey,
          child: ListView.builder(
              itemCount: controller.length,
              itemBuilder: (BuildContext context, int position) {
                return getLoginComponent(controller, context, position, node);
              }),
        ),
      ),
    );
  }

  static Container getLoginComponent(LoginController controller,
      BuildContext context, int index, FocusNode node) {
    if (null != controller.pageResponse &&
        null != controller.pageResponse!.data &&
        null != controller.pageResponse!.data!.controls) {
      switch (index) {
        case 1:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) => control.type == 'pagetitle');
            return (null != control.label && control.isEnable!)
                ? CommonViews.pageTitle(context, control.label!)
                : Container();
          }
        case 2:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'text' && control.name == 'emailid'));
            return control.isEnable!
                ? CommonViews.textFieldControl(
                    context,
                    node,
                    controller,
                    controller.nameController,
                    control.label!,
                    control.isSecure!,
                    true)
                : Container();
          }
        case 3:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'text' && control.name == 'password'));
            return control.isEnable!
                ? CommonViews.textFieldControl(
                    context,
                    node,
                    controller,
                    controller.passwordController,
                    control.name!,
                    control.isSecure!,
                    true)
                : Container();
          }
        case 4:
          {
            return Container(
              child: nonDesktopView(controller, context),
            );
          }
        case 5:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'button' && control.name == 'Login'));
            return control.isEnable!
                ? loginButton(context, controller, control)
                : Container();
          }
        case 6:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) => (control.type == 'link' &&
                    control.name == 'ForgotPassword'));
            return control.isEnable! ? forgotPassword(control) : Container();
          }
        case 7:
          {
            Controls studentControl = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'link' && control.name == 'Student'));
            Controls mentorControl = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'link' && control.name == 'Mentor'));
            return signupContainer(context, studentControl, mentorControl);
          }
        default:
          {
            return Container();
          }
      }
    } else {
      return Container(
        child: Text('Loading ......'),
      );
    }
  }

  static dynamic nonDesktopView(
      LoginController controller, BuildContext context) {
    return controller.isFaceID && !PlatformInfo.isWeb()
        ? InkWell(
            onTap: () => controller.authenticate(
                controller.nameController.text,
                controller.passwordController.text,
                controller.isFaceID,
                controller.passwordControl!),
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
