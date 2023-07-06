import 'dart:convert';

List<GalleryResponse> galleryDataJson(String str) =>
    List<GalleryResponse>.from(
        json.decode(str).map((x) => GalleryResponse.fromJson(x)));

String galleryDataToJson(List<GalleryResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GalleryResponse {
  GalleryResponse({
    required this.galId,
    required this.galName,
    required this.galImage,
  });

  int galId;
  String galName;
  List<GalImage> galImage;

  factory GalleryResponse.fromJson(Map<String, dynamic> json) => GalleryResponse(
    galId: json["gal_id"],
    galName: json["gal_name"],
    galImage: List<GalImage>.from(json["gal_image"].map((x) => GalImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gal_id": galId,
    "gal_name": galName,
    "gal_image": List<dynamic>.from(galImage.map((x) => x.toJson())),
  };
}

class GalImage {
  GalImage({
    required this.url,
  });

  String url;

  factory GalImage.fromJson(Map<String, dynamic> json) => GalImage(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}
