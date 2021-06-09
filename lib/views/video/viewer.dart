import 'package:brew/constants/brewconstants.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Viewer extends StatefulWidget {
  final String? url;
  final UniqueKey? newKey;
  Viewer({required this.url, required this.newKey}) : super(key: newKey);

  @override
  State<StatefulWidget> createState() {
    return _ViewerState();
  }
}

class _ViewerState extends State<Viewer> {
  VideoPlayerController? videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    logger.d('widget.url! : ' + widget.url!);
    this._chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(widget.url!),
        aspectRatio: 16 / 9,
        autoInitialize: true,
        autoPlay: false,
        looping: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: Text(
                errorMessage,
                style: TextStyle(color: BrewConstants.white),
              ),
            ),
          );
        });
    // videoPlayerController = VideoPlayerController.network(widget.url!);

    // final playerWidget = Chewie(
    //   controller: chewieController!,
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Container(
        width: 100.0,
        height: 20.0,
        child: this._chewieController!.autoInitialize
            ? Chewie(
                controller: this._chewieController!,
              )
            : CircularProgressIndicator(
                value: 2,
                semanticsLabel: 'Linear progress indicator',
              ),
      ),
    );
  }

  // @override
  // void didUpdateWidget(covariant Viewer oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   videoPlayerController!.initialize().then((value) {
  //     setState(() {});
  //   });
  //   // TODO: implement didUpdateWidget
  // }

  // @override
  // Widget build(BuildContext context) {
  //   logger.d('Viewer : ' + widget.url!);

  //   return AspectRatio(
  //     aspectRatio: 2.5,
  //     child: Container(
  //       width: 100.0,
  //       height: 20.0,
  //       child: Chewie(
  //         controller: chewieController!,
  //       ),
  //       // child: HtmlWidget(
  //       //   '''
  //       //           <video controls>
  //       //             <source src="${widget.url}" type="video/mp4">
  //       //             Your browser does not support HTML5 video.
  //       //           </video>''',
  //       //   buildAsync: true,
  //       //   factoryBuilder: () => MyWidgetFactory(),
  //       // ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    this._chewieController!.videoPlayerController.dispose();
    this._chewieController!.dispose();
    // _chewieController!.chewieController.dispose();
    super.dispose();
  }
}

// class MyWidgetFactory extends WidgetFactory with ChewieFactory {}
