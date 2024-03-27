import 'dart:convert';

ResponseFigHistory responseFigHistoryFromJson(String str) =>
    ResponseFigHistory.fromJson(json.decode(str));

String responseFigHistoryToJson(ResponseFigHistory data) =>
    json.encode(data.toJson());

class ResponseFigHistory {
  bool resp;
  String message;
  List<FigReward> rewardData;
  List<FigUsage> usageData;

  ResponseFigHistory(
      {required this.resp,
      required this.message,
      required this.rewardData,
      required this.usageData});

  factory ResponseFigHistory.fromJson(Map<String, dynamic> json) =>
      ResponseFigHistory(
        resp: json["resp"],
        message: json["message"],
        rewardData: List<FigReward>.from(
            json["figReward"].map((x) => FigReward.fromJson(x))),
        usageData: List<FigUsage>.from(
            json["figUsage"].map((x) => FigUsage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "figReward": List<dynamic>.from(rewardData.map((x) => x.toJson())),
        "figUsage": List<dynamic>.from(usageData.map((x) => x.toJson())),
      };
}

// 지급 내역
class FigReward {
  int event_part_no;
  // String eid;
  String acquired_time; // 지급 일시
  String event_name; // 이벤트 이름
  String fig_payment; // 무화과 개수

  FigReward({
    required this.event_part_no,
    // required this.eid,
    required this.acquired_time,
    required this.event_name,
    required this.fig_payment,
  });

  factory FigReward.fromJson(Map<String, dynamic> json) => FigReward(
        event_part_no: json["event_part_no"],
        // eid: json["eid"],
        acquired_time: json["acquired_time"],
        event_name: json["event_name"],
        fig_payment: json["fig_payment"],
      );

  Map<String, dynamic> toJson() => {
        "event_part_no": event_part_no,
        // "eid": eid,
        "acquired_time": acquired_time,
        "event_name": event_name,
        "fig_payment": fig_payment,
      };
}

// 사용 내역
class FigUsage {
  int fig_usage_no;
  String fig_used_date; // 사용 일시
  String product_name; // 제품 이름
  String product_cost; // 제품 비용
  String product_stock; // 제품 재고

  FigUsage({
    required this.fig_usage_no,
    required this.fig_used_date,
    required this.product_name,
    required this.product_cost,
    required this.product_stock,
  });

  factory FigUsage.fromJson(Map<String, dynamic> json) => FigUsage(
        fig_usage_no: json["fig_usage_no"],
        fig_used_date: json["fig_used_date"],
        product_name: json["product_name"],
        product_cost: json["product_cost"],
        product_stock: json["product_stock"],
      );

  Map<String, dynamic> toJson() => {
        "fig_usage_no": fig_usage_no,
        "fig_used_date": fig_used_date,
        "product_name": product_name,
        "product_cost": product_cost,
        "product_stock": product_stock,
      };
}
