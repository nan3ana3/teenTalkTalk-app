// import 'dart:convert';

// ResponseSearch responseSearchFromJson(String str) =>
//     ResponseSearch.fromJson(json.decode(str));

// String responseSearchToJson(ResponseSearch data) => json.encode(data.toJson());

// class ResponseSearch {
//   ResponseSearch({
//     required this.resp,
//     required this.message,
//     required this.policyFind,
//   });

//   bool resp;
//   String message;
//   List<PolicyFind> policyFind;

//   factory ResponseSearch.fromJson(Map<String, dynamic> json) => ResponseSearch(
//         resp: json["resp"],
//         message: json["message"],
//         policyFind: List<PolicyFind>.from(
//             json["policyFind"].map((x) => PolicyFind.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "resp": resp,
//         "message": message,
//         "policyFind": List<dynamic>.from(policyFind.map((x) => x.toJson())),
//       };
// }

// class PolicyFind {
//   String policy_institution_code; // 주최측
//   String policy_name; // 정책 이름
//   String application_start_date; // 모집 시작 날짜
//   String application_end_date; // 모집 마감 날짜
//   // String policy_target, // 모집 대상
//   // String content; // 상세내용
//   String img; // 정책 대표 이미지

//   PolicyFind({
//     required this.policy_institution_code,
//     required this.policy_name,
//     required this.application_start_date,
//     required this.application_end_date,
//     // required this.policy_target,
//     // required this.content,
//     required this.img,
//   });

//   factory PolicyFind.fromJson(Map<String, dynamic> json) => PolicyFind(
//       policy_institution_code: json["policy_institution_code"],
//       policy_name: json["policy_name"],
//       application_start_date: json["application_start_date"],
//       application_end_date: json["application_end_date"],
//       // policy_target: json["policy_target"],
//       // content: json["content"],
//       img: json["img"]);

//   Map<String, dynamic> toJson() => {
//         "policy_name": policy_name,
//         "application_start_date": application_start_date,
//         "application_end_date": application_end_date,
//         // "policy_target" : policy_target,
//         // "content": content,
//         "img:": img
//       };
// }
