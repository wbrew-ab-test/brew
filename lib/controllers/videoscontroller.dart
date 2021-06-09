import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/video/videoleaf.dart';
import 'package:brew/models/video/videoresponse.dart';
import 'package:brew/services/videosservice.dart';
import 'package:get/get.dart';

class VideosController extends GetxController {
  bool isLoaded = false;
  List<Videoleaf>? videolist;
  Videoleaf? videoleaf;
  int index = 0;
  @override
  void onInit() async {
    super.onInit();

    late Future<Response> appMenu = Get.find<VideosService>().getListOfVideos();
    await appMenu.then((listOfVideos) {
      VideoResponse response = VideoResponse.fromJson(listOfVideos.body);
      logger.d('response : ' + response.data[0].videolist[0].videourl);
      this.videolist = response.data[0].videolist;
      this.isLoaded = true;
      this.videoleaf = this.videolist![0];
      this.index = 0;
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
