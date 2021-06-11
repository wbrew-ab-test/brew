import 'package:brew/helper/platforminfo.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:brew/views/menu/brewmenu.dart';
import 'package:brew/views/video/webVideoContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Pulse - Nest',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    final double width = (MediaQuery.of(context).size.width * 1);
    FocusNode node = new FocusNode();
    return Scaffold(
      appBar: CommonViews.getAppBar('Nest'),
      drawer: BrewMenu(),
      body: PlatformInfo.isWeb()
          ? WebVideoContainer(
              isMobile: false,
              width: width,
            )
          : WebVideoContainer(
              isMobile: true,
              width: width,
            ),
    );
  }
}
