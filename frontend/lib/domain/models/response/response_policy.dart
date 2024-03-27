import 'dart:convert';

ResponsePolicy responsePolicyFromJson(String str) =>
    ResponsePolicy.fromJson(json.decode(str));

String responsePolicyToJson(ResponsePolicy data) => json.encode(data.toJson());

class ResponsePolicy {
  bool resp;
  String message;
  List<Policy> policies;

  ResponsePolicy({
    required this.resp,
    required this.message,
    required this.policies,
  });

  factory ResponsePolicy.fromJson(Map<String, dynamic> json) => ResponsePolicy(
        resp: json["resp"],
        message: json["message"],
        policies:
            List<Policy>.from(json["policies"].map((x) => Policy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "policies": List<dynamic>.from(policies.map((x) => x.toJson())),
      };
}

class Policy {
  int board_idx;
  String pid;
  String policy_institution_code; // 주최측
  String policy_name; // 정책 이름
  String application_start_date; // 모집 시작 날짜
  String application_end_date; // 모집 마감 날짜
  String policy_target_code; // 모집 대상
  String policy_field_code; // 정책 분야
  String policy_character_code; // 정책 성격
  int count_scraps; // 스크랩 수
  int count_views; // 조회수
  String content; // 상세내용
  String img; // 정책 대표 이미지
  String policy_link; // 정책 신청 링크

  Policy({
    required this.board_idx,
    required this.pid,
    required this.policy_institution_code,
    required this.policy_name,
    required this.application_start_date,
    required this.application_end_date,
    required this.policy_target_code,
    required this.policy_character_code,
    required this.policy_field_code,
    required this.count_scraps,
    required this.count_views,
    required this.content,
    required this.img,
    required this.policy_link,
  });

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
      board_idx: json["board_idx"],
      pid: json["uid"],
      application_start_date: json["application_start_date"],
      application_end_date: json["application_end_date"],
      img: json["img"],
      policy_name: json["policy_name"],
      policy_target_code: json["policy_target_code"],
      content: json["content"],
      policy_institution_code: json["policy_institution_code"],
      policy_character_code: json["policy_character_code"],
      policy_field_code: json["policy_field_code"],
      count_scraps: json["count_scraps"],
      count_views: json["count_views"],
      policy_link: json["policy_link"]);

  Map<String, dynamic> toJson() => {
        "board_idx": board_idx,
        "uid": pid,
        "policy_supervision": policy_institution_code,
        "policy_name": policy_name,
        "application_start_date": application_start_date,
        "application_end_date": application_end_date,
        "policy_target_code": policy_target_code,
        "policy_character_code": policy_character_code,
        "policy_field_code": policy_field_code,
        "count_scraps": count_scraps,
        "count_views": count_views,
        "content": content,
        "img:": img,
        "policy_link": policy_link
      };
}
