import 'package:brew/controllers/videoscontroller.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/services/videosservice.dart';
import 'package:brew/views/common/commonviews.dart';
import 'package:brew/views/video/viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_chewie/fwfh_chewie.dart';
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

    // return this.isMobile!
    //     ? Container(
    //         color: Colors.white,
    //         child: Container(
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 flex: 3,
    //                 child: Container(
    //                   child: ListView(
    //                     children: <Widget>[
    //                       GetBuilder<VideosController>(
    //                         init: VideosController(),
    //                         builder: (controller) => (controller.videolist !=
    //                                     null &&
    //                                 controller.videolist!.length > 0)
    //                             ? Column(
    //                                 children: [
    //                                   videoController(
    //                                       controller.videolist![0].videourl),
    //                                   CommonViews.richVideoBar(),
    //                                   CommonViews.videoList(
    //                                       controller.videolist)
    //                                 ],
    //                               )
    //                             : Container(
    //                                 child: Text('Not Loaded'),
    //                               ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
    //     : Container(
    //         color: Colors.white,
    //         child: Container(
    //           child: Row(
    //             children: [
    //               Expanded(
    //                 flex: this.width! > 767 ? 2 : 1,
    //                 child: Container(
    //                   child: ListView(
    //                     children: <Widget>[
    //                       GetBuilder<VideosController>(
    //                         init: VideosController(),
    //                         builder: (controller) => (controller.videolist !=
    //                                     null &&
    //                                 controller.videolist!.length > 0)
    //                             ? Column(
    //                                 children: [
    //                                   videoController(
    //                                       controller.videolist![0].videourl),
    //                                   CommonViews.richVideoBar(),
    //                                 ],
    //                               )
    //                             : Container(
    //                                 child: Text('Not Loaded'),
    //                               ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               this.width! > 767
    //                   ? Expanded(
    //                       flex: 1,
    //                       child: CommonViews.videoList(controller.videolist))
    //                   : Container(),
    //             ],
    //           ),
    //         ),
    //       );

    // return Container(
    //   child: ListView(
    //     children: <Widget>[
    //       GetBuilder<VideosController>(
    //         init: VideosController(),
    //         builder: (controller) => (controller.videolist != null &&
    //                 controller.videolist!.length > 0)
    //             ? Column(
    //                 children: [
    //                   videoController(controller.videolist![0].videourl),
    //                   CommonViews.richVideoBar(),
    //                   this.isMobile!
    //                       ? CommonViews.videoList(controller.videolist)
    //                       : Container(),
    //                 ],
    //               )
    //             : Container(
    //                 child: Text('Not Loaded'),
    //               ),
    //       ),
    //     ],
    //   ),
    // );

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
                                        // videoController(
                                        //     controller.videoleaf!.videourl),
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
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    flex: this.width! > 767 ? 2 : 1,
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                          GetBuilder<VideosController>(
                            init: VideosController(),
                            builder: (controller) =>
                                (controller.videolist != null &&
                                        controller.videolist!.length > 0)
                                    ? Column(
                                        children: [
                                          // videoController(
                                          //     controller.videolist![0].videourl),
                                          Viewer(
                                            url: controller.videoleaf!.videourl,
                                            newKey: UniqueKey(),
                                          ),
                                          CommonViews.richVideoBar(
                                              controller.videolist![0].title),
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
                  this.width! > 767
                      ? Expanded(child: CommonViews.mockedList())
                      : Container(),
                ],
              ),
            ),
          );
  }

  AspectRatio videoController(String url) {
    logger.d('JURL FOR VIDEO : ' + url);
    return AspectRatio(
      aspectRatio: 2.5,
      child: Container(
        width: 100.0,
        height: 20.0,
        child: HtmlWidget(
          '''
                  <video controls>
                    <source src="${url}" type="video/mp4">
                    Your browser does not support HTML5 video.
                  </video>''',
          buildAsync: true,
          factoryBuilder: () => MyWidgetFactory(),
        ),
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with ChewieFactory {}
