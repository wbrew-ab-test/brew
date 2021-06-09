import 'package:brew/models/video/videolist.dart';

class VideoResponse {
  List<VideoList> data;
  VideoResponse({
    required this.data,
  });

  factory VideoResponse.fromJson(Map<String, dynamic> json) => VideoResponse(
        data: List<VideoList>.from(
            json["data"].map((x) => VideoList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<VideoList>.from(data.map((x) => x.toJson())),
      };
}
