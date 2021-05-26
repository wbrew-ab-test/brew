import 'package:brew/constants/brewconstants.dart';
import 'package:brew/helper/platforminfo.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:brew/views/menu/brewmenu.dart';
import 'package:flutter/material.dart';

class BrewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode node = new FocusNode();
    return Scaffold(
        appBar: CommonViews.getAppBar('Dashboard'),
        drawer: BrewMenu(),
        body: PlatformInfo.isWeb() ? Text('Desktop!') : Text('Mobile'));
  }
}
