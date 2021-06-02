import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/menucontroller.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/services/menuservice.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrewMenu extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MenuService());
    logger.d('Inside the Brew Menu...');
    return Drawer(
      child: Container(
        color: BrewConstants.pulseBlue,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GetBuilder<MenuController>(
              init: MenuController(),
              builder: (controller) => controller.menu != null
                  ? CommonViews.populateMenu(controller)
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: <Widget>[
                            CircularProgressIndicator(
                              value: 2,
                              semanticsLabel: 'Linear progress indicator',
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
