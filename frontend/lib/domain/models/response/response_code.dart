// import 'dart:convert';

// ResponseCode responseCodeFromJson(String str) =>
//     ResponseCode.fromJson(json.decode(str));

// String responseCodeToJson(ResponseCode data) => json.encode(data.toJson());

// class ResponseCode {
//   bool resp;
//   String message;
//   List<commonCode> codes;

//   ResponseCode(
//       {required this.resp, required this.message, required this.codes});

//   factory ResponseCode.fromJson(Map<String, dynamic> json) => ResponseCode(
//       resp: json['resp'],
//       message: json['message'],
//       codes: List<commonCode>.from(
//           json['codes'].map((x) => commonCode.fromJson(x))).toList());

//   Map<String, dynamic> toJson() => {
//         "resp": resp,
//         "message": message,
//         "codes": List<dynamic>.from(codes.map((x) => x.toJson()).toList())
//       };
// }

// class commonCode {
//   String code;
//   String code_name;
//   String code_english_name;
//   String code_desc;
//   String code_use_yn;
//   List<commonCodeDetail> codeDetails;

//   commonCode({
//     required this.code,
//     required this.code_name,
//     required this.code_english_name,
//     required this.code_desc,
//     required this.code_use_yn,
//     required this.codeDetails,
//   });

//   factory commonCode.fromJson(Map<String, dynamic> json) => commonCode(
//       code: json["code"],
//       code_name: json["code_name"],
//       code_english_name: json["code_english_name"],
//       code_desc: json["code_desc"],
//       code_use_yn: json["code_use_yn"],
//       codeDetails: List<commonCodeDetail>.from(
//               json["codeDetails"].map((x) => commonCodeDetail.fromJson(x)))
//           .toList());

//   Map<String, dynamic> toJson() => {
//         'code': code,
//         'code_name': code_name,
//         'code_english_name': code_english_name,
//         'code_desc': code_desc,
//         'code_use_yn': code_use_yn,
//         "codes": List<dynamic>.from(codeDetails.map((x) => x.toJson()).toList())
//       };
// }

// class commonCodeDetail {
//   String code;
//   String code_detail;
//   String code_detail_name;
//   String code_detail_desc;
//   String code_detail_use_yn;

//   commonCodeDetail(
//       {required this.code,
//       required this.code_detail,
//       required this.code_detail_name,
//       required this.code_detail_desc,
//       required this.code_detail_use_yn});

//   factory commonCodeDetail.fromJson(Map<String, dynamic> json) =>
//       commonCodeDetail(
//           code: json["code"],
//           code_detail: json["code_detail"],
//           code_detail_name: json["code_detail_name"],
//           code_detail_desc: json["code_detail_desc"],
//           code_detail_use_yn: json["code_detail_use_yn"]);

//   Map<String, dynamic> toJson() => {
//         'code': code,
//         'code_detail': code_detail,
//         'code_detail_name': code_detail_name,
//         'code_detail_desc': code_detail_desc,
//         'code_detail_use_yn': code_detail_use_yn
//       };
// }
