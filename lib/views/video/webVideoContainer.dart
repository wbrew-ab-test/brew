import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_chewie/fwfh_chewie.dart';

class WebVideoContainer extends StatelessWidget {
  late final String? videoUrl;
  // final htmlString =
  WebVideoContainer({required this.videoUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: HtmlWidget(
        '''<video controls>
              <source src="${this.videoUrl}" type="video/mp4">
              Your browser does not support HTML5 video.
            </video>''',
        factoryBuilder: () => MyWidgetFactory(),
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with ChewieFactory {}
