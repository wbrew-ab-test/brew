import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/signupcontroller.dart';
import 'package:brew/helper/modedetector.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/page/pageresponse.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SignupViews {
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
                    ? GetBuilder<SignupController>(
                        init: SignupController(),
                        builder: (controller) => Expanded(
                          flex: 2,
                          child: (null != controller.sideBarPath)
                              ? CommonViews.loadBackgroundImage(
                                  controller.sideBarPath, context)
                              : Container(),
                        ),
                      )
                    : Container(),
                GetBuilder<SignupController>(
                  init: SignupController(),
                  builder: (controller) =>
                      signupForm(controller, context, node),
                ),
              ],
              // children: <Widget>[
              //   width > 767
              //       ? Expanded(
              //           flex: 2,
              //           child: CommonViews.backgroundImage(context),
              //         )
              //       : Container(),
              //   signupForm(context, node),
              // ],
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
                GetBuilder<SignupController>(
                  init: SignupController(),
                  builder: (controller) =>
                      signupForm(controller, context, node),
                ),
                // signupForm(context, node),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container signupButton(
      BuildContext context, SignupController controller, Controls control) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: RaisedButton(
        textColor: BrewConstants.white,
        color: BrewConstants.pulseBlue,
        child: Text(control.name!),
        onPressed: () {
          controller.signup(control);
        },
      ),
    );
  }

  static Container gotoLogin(BuildContext context, Controls control) {
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
                // Get.back();
                Get.toNamed(control.route!);
              },
              child: Text(control.label!,
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
      SignupController controller, BuildContext context, FocusNode node) {
    // SignupController controller = new SignupController();
    logger.d('controller : ' + controller.pageResponse!.data!.collectionName!);
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
        alignment: Alignment.center,
        child: new Form(
          key: SignupController.signupFormKey,
          child: ListView.builder(
              itemCount: controller.length,
              itemBuilder: (BuildContext context, int position) {
                // return Container(
                //   child: Text('Signup'),
                // );
                return getStudentSignupComponent(
                    controller, context, position, node);
              }),
          // child: ListView(
          //   children: <Widget>[
          //     CommonViews.pageTitle(context, BrewConstants.pulse),
          //     CommonViews.textFieldControl(
          //         context,
          //         node,
          //         controller,
          //         controller.firstNameController,
          //         BrewConstants.firstName,
          //         false,
          //         true),
          //     CommonViews.textFieldControl(
          //         context,
          //         node,
          //         controller,
          //         controller.lastNameController,
          //         BrewConstants.lastName,
          //         false,
          //         true),
          //     CommonViews.textFieldControl(
          //         context,
          //         node,
          //         controller,
          //         controller.displayNameController,
          //         BrewConstants.displayName,
          //         false,
          //         true),
          //     CommonViews.textFieldControl(
          //         context,
          //         node,
          //         controller,
          //         controller.emailController,
          //         BrewConstants.emailAddress,
          //         false,
          //         true),
          //     CommonViews.textFieldControl(
          //         context,
          //         node,
          //         controller,
          //         controller.passwordController,
          //         BrewConstants.password,
          //         true,
          //         true),
          //     CommonViews.textFieldControl(
          //         context,
          //         node,
          //         controller,
          //         controller.confirmPasswordController,
          //         BrewConstants.confirmPassword,
          //         true,
          //         true),
          //     signupButton(controller),
          //     GetBuilder<SignupController>(
          //       init: SignupController(),
          //       builder: (controller) =>
          //           controller.registrationSuccessful.toString() == '0'
          //               ? CommonViews.error('User Already Exist')
          //               : Container(),
          //     ),
          //     gotoLogin(context)
          //   ],
          // ),
        ),
      ),
    );
  }

  static Container getStudentSignupComponent(SignupController controller,
      BuildContext context, int index, FocusNode node) {
    logger.d('getStudentSignupComponent index : ' + index.toString());
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
                    (control.type == 'text' && control.name == 'firstname'));
            return (null != control.label && control.isEnable!)
                ? CommonViews.textFieldControl(
                    context,
                    node,
                    controller,
                    controller.firstNameController,
                    control.label!,
                    control.isSecure!,
                    true)
                : Container();
          }
        case 3:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'text' && control.name == 'lastname'));
            return (null != control.label && control.isEnable!)
                ? CommonViews.textFieldControl(
                    context,
                    node,
                    controller,
                    controller.lastNameController,
                    control.label!,
                    control.isSecure!,
                    true)
                : Container();
          }
        case 4:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'text' && control.name == 'displayname'));
            return (null != control.label && control.isEnable!)
                ? CommonViews.textFieldControl(
                    context,
                    node,
                    controller,
                    controller.lastNameController,
                    control.label!,
                    control.isSecure!,
                    true)
                : Container();
          }
        case 5:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'text' && control.name == 'emailid'));
            return (null != control.label && control.isEnable!)
                ? CommonViews.textFieldControl(
                    context,
                    node,
                    controller,
                    controller.lastNameController,
                    control.label!,
                    control.isSecure!,
                    true)
                : Container();
          }
        case 6:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'text' && control.name == 'password'));
            return (null != control.label && control.isEnable!)
                ? CommonViews.textFieldControl(
                    context,
                    node,
                    controller,
                    controller.lastNameController,
                    control.label!,
                    control.isSecure!,
                    true)
                : Container();
          }
        case 7:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) => (control.type == 'text' &&
                    control.name == 'confirmpassword'));
            return (null != control.label && control.isEnable!)
                ? CommonViews.textFieldControl(
                    context,
                    node,
                    controller,
                    controller.lastNameController,
                    control.label!,
                    control.isSecure!,
                    true)
                : Container();
          }
        case 8:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'button' && control.name == 'Sign Up'));
            return control.isEnable!
                ? signupButton(context, controller,
                    control) // loginButton(context, controller, control)
                : Container();
          }
        case 9:
          {
            Controls control = controller.pageResponse!.data!.controls!
                .firstWhere((control) =>
                    (control.type == 'link' && control.name == 'login'));
            return control.isEnable!
                ? gotoLogin(context, control)
                : Container();
          }
        default:
          {
            return Container();
          }
      }
    } else {
      return Container();
    }
  }
}
