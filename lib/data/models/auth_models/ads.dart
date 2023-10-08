class AdResponse {
  final List<Ad>? ads;

  const AdResponse({this.ads});

  factory AdResponse.fromJson(Map<String, dynamic> json) => AdResponse(
        ads: json["data"] != null
            ? List<Ad>.from(
                json["data"].map((ad) => Ad.fromJson(ad)),
              )
            : null,
      );
}

class Ad {
  Ad({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
    // required this.deletedAt,
  });

  final int? id;
  final String? title;
  final String? body;
  final String? image;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        body: json["body"] ?? '',
        image: json["image"] ?? '',
      );
}
