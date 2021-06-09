import 'package:brew/helper/platforminfo.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:brew/views/menu/brewmenu.dart';
import 'package:brew/views/video/webVideoContainer.dart';
import 'package:flutter/material.dart';

class BrewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.of(context).size.width * 1);
    FocusNode node = new FocusNode();
    return Scaffold(
      appBar: CommonViews.getAppBar('Dashboard'),
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
      // body: PlatformInfo.isWeb()
      //     ? Container(
      //         color: Colors.white,
      //         child: Container(
      //           child: Row(
      //             children: [
      //               Expanded(
      //                 flex: width > 767 ? 2 : 1,
      //                 child: Container(
      //                   child: WebVideoContainer(
      //                     isMobile: false,
      //                     width: width,
      //                   ),
      //                 ),
      //               ),
      //               width > 767
      //                   ? Expanded(flex: 1, child: CommonViews.mockedList())
      //                   : Container(),
      //             ],
      //           ),
      //         ),
      //       )
      //     : Container(
      //         color: Colors.white,
      //         child: Container(
      //           child: Column(
      //             children: [
      //               Expanded(
      //                 flex: 3,
      //                 child: WebVideoContainer(
      //                   isMobile: true,
      //                   width: width,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
    );
  }
}
