import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/profilecontroller.dart';
import 'package:brew/helper/platforminfo.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Profile extends StatelessWidget {
  final Size? screenSize;

  Profile({required this.screenSize});
  final String _fullName = "John Frost";
  @override
  Widget build(BuildContext context) {
    FocusNode node = new FocusNode();
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Pulse - My Profile',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    logger.d('scrreensize : ' + this.screenSize!.toString());
    return Stack(
      children: [
        // _buildCoverImage(this.screenSize!),
        GetBuilder(
          init: ProfileController(),
          builder: (ProfileController controller) => controller.profile != null
              ? SafeArea(
                  child: ListView(
                      // scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: <Widget>[
                        // SizedBox(height: screenSize!.height / 6.4),
                        _buildProfileImage(),
                        _buildFullName(controller),
                        PlatformInfo.isWeb()
                            ? _buildSeparator(this.screenSize!)
                            : Container(),
                        _buildProfileDetails(
                            context, this.screenSize!, controller, node),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.isEnabled
                                ? _saveButton(context, controller)
                                : Container(),
                            controller.isEnabled
                                ? _cancelButton(context, controller)
                                : Container(),
                          ],
                        ),
                        controller.isEnabled
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 24.0))
                            : Container(),
                        PlatformInfo.isWeb()
                            ? _buildSeparator(this.screenSize!)
                            : Container(),
                      ]),
                )
              : Container(),
        ),
      ],
    );
  }

  static Container _saveButton(
      BuildContext context, ProfileController controller) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: RaisedButton(
        textColor: BrewConstants.white70,
        color: BrewConstants.pulseBlue,
        child: Text('Save'),
        onPressed: () {
          // controller.login();
        },
      ),
    );
  }

  static Container _cancelButton(
      BuildContext context, ProfileController controller) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: RaisedButton(
        textColor: BrewConstants.white70,
        color: BrewConstants.pulseBlue,
        child: Text('Cancel'),
        onPressed: () {
          logger.d('CANCEL!!!!');
          controller.setEnabled(false);
          controller.applyUpdate();
        },
      ),
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 4.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/profile_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/avatar.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName(ProfileController controller) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Center(
      child: RichText(
        text: TextSpan(
          style: _nameTextStyle,
          children: [
            TextSpan(
              text: BrewConstants.space +
                  controller.profile!.data!.firstName! +
                  BrewConstants.space +
                  controller.profile!.data!.lastName!,
            ),
            WidgetSpan(
              child: IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                icon: Icon(Icons.edit),
                onPressed: () {
                  logger.d('EDIT ICON CLICKED!');
                  controller.setEnabled(true);
                  controller.applyUpdate();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.3,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildProfileDetails(BuildContext context, Size screenSize,
      ProfileController controller, FocusNode node) {
    return Container(
      width: screenSize.width / 1.3,
      // height: 2.0,
      // color: Colors.black54,
      padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
      child: Column(
        children: [
          CommonViews.textFieldControl(
              context,
              node,
              controller,
              controller.firstNameController,
              BrewConstants.firstName,
              false,
              controller.isEnabled),
          CommonViews.textFieldControl(
              context,
              node,
              controller,
              controller.lastNameController,
              BrewConstants.lastName,
              false,
              controller.isEnabled),
          CommonViews.textFieldControl(
              context,
              node,
              controller,
              controller.displayNameController,
              BrewConstants.displayName,
              false,
              controller.isEnabled),
          CommonViews.textFieldControl(
              context,
              node,
              controller,
              controller.emailController,
              BrewConstants.emailAddress,
              false,
              controller.isEnabled),
          (null != controller.profile!.data!.persona &&
                  controller.profile!.data!.persona == 'student')
              ? CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.desiredBandController,
                  BrewConstants.desiredBand,
                  false,
                  controller.isEnabled)
              : Container(),
          (null != controller.profile!.data!.persona &&
                  controller.profile!.data!.persona == 'student')
              ? CommonViews.textFieldControl(
                  context,
                  node,
                  controller,
                  controller.enrolledController,
                  BrewConstants.enrolledPlan,
                  false,
                  controller.isEnabled)
              : Container(),
        ],
      ),
    );
  }
}
