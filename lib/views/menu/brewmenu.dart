import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/menucontroller.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/services/menuservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrewMenu extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MenuService());
    logger.d('Inside the Brew Menu...');
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GetBuilder(
              init: MenuController(),
              builder: (controller) {
                // return Text('Text');
                return Expanded(
                  flex: 1,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.supervised_user_circle,
                              size: 50, color: BrewConstants.white),
                        ),
                        decoration: BoxDecoration(
                          color: BrewConstants.pulseBlue,
                        ),
                      ),

                      // for (int x=0; x < controller.menu.length; x++) {

                      // }
                      ListTile(
                        title: Text('Profile'),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
              }),

          // Expanded(
          //       child: DrawerHeader(
          //         child: Align(
          //           alignment: Alignment.topLeft,
          //           child: Icon(
          //             Icons.supervised_user_circle,
          //             size: 50,
          //             color: BrewConstants.white,
          //           ),
          //         ),
          //         // Text('Profile',
          //         //     style: TextStyle(
          //         //         fontWeight: FontWeight.bold,
          //         //         fontSize: 32.0,
          //         //         color: BrewConstants.WHITE)),
          //         decoration: BoxDecoration(
          //           color: BrewConstants.pulseBlue,
          //         ),
          //       ),
          //     )),
        ],
      ),
    );
  }
}
