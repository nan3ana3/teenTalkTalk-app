import 'dart:convert';

ResponseBanner responseBannerFromJson(String str) =>
    ResponseBanner.fromJson(json.decode(str));

String responseBannerToJson(ResponseBanner data) => json.encode(data.toJson());

class ResponseBanner {
  bool resp;
  String message;
  List<Banners> banners;

  ResponseBanner({
    required this.resp,
    required this.message,
    required this.banners,
  });

  factory ResponseBanner.fromJson(Map<String, dynamic> json) => ResponseBanner(
      resp: json["resp"],
      message: json["message"],
      banners:
          List<Banners>.from(json["banners"].map((x) => Banners.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
      };
}

class Banners {
  String banner_name;
  String banner_img;
  String banner_link;

  Banners({
    required this.banner_name,
    required this.banner_img,
    required this.banner_link,
  });

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        banner_name: json["banner_name"] as String,
        banner_img: json["banner_img"] as String,
        banner_link: json["banner_link"] as String,
      );

  Map<String, dynamic> toJson() => {
        "banner_name": banner_name,
        "banner_img": banner_img,
        "banner_link": banner_link,
      };
}
