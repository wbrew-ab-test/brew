import 'package:brew/helper/platforminfo.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:brew/views/menu/brewmenu.dart';
import 'package:brew/views/profile/profile.dart';
import 'package:brew/views/video/webVideoContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BrewProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.of(context).size.width * 1);
    final Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Pulse - My Profile',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      appBar: CommonViews.getAppBar('My Profile'),
      drawer: BrewMenu(),
      body: Container(
        child: Profile(screenSize: screenSize),
      ),
    );
  }
}
