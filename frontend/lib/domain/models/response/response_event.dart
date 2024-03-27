import 'dart:convert';

ResponseEvent responseEventFromJson(String str) =>
    ResponseEvent.fromJson(json.decode(str));

String responseEventToJson(ResponseEvent data) => json.encode(data.toJson());

class ResponseEvent {
  bool resp;
  String message;
  List<EventData> eventData;

  ResponseEvent({
    required this.resp,
    required this.message,
    required this.eventData,
  });

  factory ResponseEvent.fromJson(Map<String, dynamic> json) => ResponseEvent(
        resp: json["resp"],
        message: json["message"],
        eventData: List<EventData>.from(
            json["eventData"].map((x) => EventData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "eventData": List<dynamic>.from(eventData.map((x) => x.toJson())),
      };
}

// 이벤트 정보
class EventData {
  String eid; // 이벤트 아이디
  String event_name; // 이벤트 이름
  String fig_payment; // 지급 무화과 개수
  String event_start_date; // 이벤트 시작 날짜
  String event_end_date; // 이벤트 끝 날짜

  EventData({
    required this.eid,
    required this.event_name,
    required this.fig_payment,
    required this.event_start_date,
    required this.event_end_date,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
        eid: json["eid"],
        event_name: json["event_name"],
        fig_payment: json["fig_payment"],
        event_start_date: json["event_start_date"],
        event_end_date: json["event_end_date"],
      );

  Map<String, dynamic> toJson() => {
        "eid": eid,
        "event_name": event_name,
        "fig_payment": fig_payment,
        "event_start_date": event_start_date,
        "event_end_date": event_end_date,
      };
}
