import 'package:brew/helper/platforminfo.dart';
import 'package:flutter/material.dart';

class BrewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode node = new FocusNode();
    return Scaffold(
        body: PlatformInfo.isWeb() ? Text('Desktop!') : Text('Mobile'));
  }
}
