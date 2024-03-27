import 'dart:convert';

ResponseNotice responseNoticeFromJson(String str) =>
    ResponseNotice.fromJson(json.decode(str));

String responseToJson(ResponseNotice data) => json.encode(data.toJson());

class ResponseNotice {
  bool resp;
  String message;
  List<Notice> notices;

  ResponseNotice({
    required this.resp,
    required this.message,
    required this.notices,
  });

  factory ResponseNotice.fromJson(Map<String, dynamic> json) => ResponseNotice(
        resp: json["resp"],
        message: json["message"],
        notices:
            List<Notice>.from(json["notices"].map((x) => Notice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "notices": List<dynamic>.from(notices.map((x) => x.toJson())),
      };
}

class Notice {
  int board_idx;
  String title; // 공지 제목
  String content; // 공지 내용
  String register_uid; // 등록자 정보
  String ins_date; // 공지 등록 날짜

  Notice({
    required this.board_idx,
    required this.title,
    required this.content,
    required this.register_uid,
    required this.ins_date,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        board_idx: json["board_idx"],
        title: json["title"],
        content: json["content"],
        register_uid: json["register_uid"],
        ins_date: json["ins_date"],
      );

  Map<String, dynamic> toJson() => {
        "board_idx": board_idx,
        "title": title,
        "content": content,
        "register_uid": register_uid,
        "ins_date": ins_date,
      };
}
