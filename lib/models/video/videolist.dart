import 'package:brew/models/video/videoleaf.dart';

class VideoList {
  List<Videoleaf> videolist;
  VideoList({
    required this.videolist,
  });

  factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
        videolist: List<Videoleaf>.from(
            json['videolist'].map((x) => Videoleaf.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'videolist': List<dynamic>.from(videolist.map((x) => x.toJson())),
      };
}
