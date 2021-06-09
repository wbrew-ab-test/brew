class Videoleaf {
  String videoid;
  String title;
  String videourl;
  String subtitle;

  Videoleaf(
      {required this.videoid,
      required this.title,
      required this.videourl,
      required this.subtitle});

  factory Videoleaf.fromJson(Map<String, dynamic> json) => Videoleaf(
      subtitle: json['subtitle'],
      title: json['title'],
      videoid: json['videoid'],
      videourl: json['videourl']);

  Map<String, dynamic> toJson() => {
        'subtitle': subtitle,
        'title': title,
        'videoid': videoid,
        'videourl': videourl
      };
}
