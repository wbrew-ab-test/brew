import 'package:brew/controllers/videoscontroller.dart';
import 'package:brew/services/videosservice.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:brew/views/video/viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class WebVideoContainer extends GetView<VideosController> {
  // late final String? videoUrl;
  late final double? width;
  late final bool? isMobile;
  // final htmlString =
  WebVideoContainer({required this.isMobile, required this.width});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VideosService());

    return this.isMobile!
        ? Container(
            child: Container(
              color: Colors.white,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView(
                          children: <Widget>[
                            GetBuilder<VideosController>(
                              init: VideosController(),
                              builder: (controller) => (controller.videolist !=
                                          null &&
                                      controller.videolist!.length > 0)
                                  ? Column(
                                      children: [
                                        Viewer(
                                          url: controller.videoleaf!.videourl,
                                          newKey: UniqueKey(),
                                        ),
                                        CommonViews.richVideoBar(
                                            controller.videoleaf!.title),
                                        CommonViews.videoList(
                                            controller, controller.videolist)
                                      ],
                                    )
                                  : Container(
                                      child: Text('Not Loaded'),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                GetBuilder<VideosController>(
                  init: VideosController(),
                  builder: (controller) => (controller.videolist != null &&
                          controller.videolist!.length > 0)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: this.width! > 767 ? 2 : 1,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Viewer(
                                      url: controller.videoleaf!.videourl,
                                      newKey: UniqueKey(),
                                    ),
                                    CommonViews.richVideoBar(
                                        controller.videoleaf!.title),
                                    this.width! < 767
                                        ? CommonViews.videoList(
                                            controller, controller.videolist)
                                        : Container(),

                                    // Expanded(child: CommonViews.mockedList())
                                  ]),
                            ),
                            this.width! > 767
                                ? Expanded(
                                    child: CommonViews.videoList(
                                        controller, controller.videolist))
                                : Container(),
                          ],
                        )
                      : Container(),
                ),
              ],
            ));
  }
}

//  child: Container(
//     child: Row(
//       children: [
//         Expanded(
//           flex: this.width! > 767 ? 2 : 1,
//           child: Container(
//             child: ListView(
//               children: <Widget>[
//                 GetBuilder<VideosController>(
//                   init: VideosController(),
//                   builder: (controller) =>
//                       (controller.videolist != null &&
//                               controller.videolist!.length > 0)
//                           ? Column(
//                               children: [
//                                 Viewer(
//                                   url: controller.videoleaf!.videourl,
//                                   newKey: UniqueKey(),
//                                 ),
//                                 CommonViews.richVideoBar(
//                                     controller.videolist![0].title),
//                               ],
//                             )
//                           : Container(
//                               child: Text('Not Loaded'),
//                             ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         this.width! > 767
//             ? Expanded(child: CommonViews.mockedList())
//             : Container(),
//       ],
//     ),
//   ),
