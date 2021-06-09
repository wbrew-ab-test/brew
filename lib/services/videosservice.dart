import 'package:brew/constants/brewconstants.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:get/get_connect.dart';

class VideosService extends GetConnect {
  Future<Response> getListOfVideos() {
    logger.d('Inside the Videos service...');
    final url = Uri.parse(BrewConstants.fetchVideosUrl);
    return get(url.toString(), contentType: "application/json");
  }
}
