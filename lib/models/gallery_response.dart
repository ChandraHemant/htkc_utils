import 'dart:convert';

List<HcGalleryResponse> hcGalleryDataJson(String str) =>
    List<HcGalleryResponse>.from(
        json.decode(str).map((x) => HcGalleryResponse.fromJson(x)));

String hcGalleryDataToJson(List<HcGalleryResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HcGalleryResponse {
  HcGalleryResponse({
    required this.galId,
    required this.galName,
    required this.galImage,
  });

  int galId;
  String galName;
  List<HcGalImage> galImage;

  factory HcGalleryResponse.fromJson(Map<String, dynamic> json) => HcGalleryResponse(
    galId: json["gal_id"],
    galName: json["gal_name"],
    galImage: List<HcGalImage>.from(json["gal_image"].map((x) => HcGalImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gal_id": galId,
    "gal_name": galName,
    "gal_image": List<dynamic>.from(galImage.map((x) => x.toJson())),
  };
}

class HcGalImage {
  HcGalImage({
    required this.url,
  });

  String url;

  factory HcGalImage.fromJson(Map<String, dynamic> json) => HcGalImage(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}
