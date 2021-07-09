import 'package:brew/constants/brewconstants.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Viewer extends StatefulWidget {
  final String? url;
  final UniqueKey? newKey;
  // final DocumentSnapshot? document;
  Viewer({required this.url, required this.newKey}) : super(key: newKey);

  @override
  State<StatefulWidget> createState() {
    return _ViewerState();
  }
}

class _ViewerState extends State<Viewer> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  bool fetchVideoFromOnline = true;

  void _initPlayer() async {
    this._chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(widget.url!),
        aspectRatio: 16 / 9,
        autoInitialize: true,
        allowedScreenSleep: false,
        allowFullScreen: true,
        autoPlay: false,
        looping: false,
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
  }

  @override
  void initState() {
    logger.d('widget.url! : ' + widget.url!);
    super.initState();
    _initPlayer();
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

  @override
  void dispose() {
    // this._chewieController!.videoPlayerController.dispose();
    // this._chewieController!.dispose();
    super.dispose();
  }
}
