import 'dart:convert';

ResponseUserFigCount responseUserFigCountFromJson(String str) =>
    ResponseUserFigCount.fromJson(json.decode(str));

String responseUserFigCountToJson(ResponseUserFigCount data) =>
    json.encode(data.toJson());

class ResponseUserFigCount {
  bool resp;
  String message;
  String figCount;

  ResponseUserFigCount({
    required this.resp,
    required this.message,
    required this.figCount, // 사용자 무화과 개수
  });

  factory ResponseUserFigCount.fromJson(Map<String, dynamic> json) =>
      ResponseUserFigCount(
        resp: json["resp"],
        message: json["message"],
        figCount: json["figCount"],
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "figCount": figCount,
      };
}
