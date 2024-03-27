import 'dart:convert';

ResponseTerms responseTermsFromJson(String str) =>
    ResponseTerms.fromJson(json.decode(str));

String responseTermsToJson(ResponseTerms data) => json.encode(data.toJson());

class ResponseTerms {
  bool resp;
  String message;
  List<TermsData> termsData;

  ResponseTerms({
    required this.resp,
    required this.message,
    required this.termsData,
  });

  factory ResponseTerms.fromJson(Map<String, dynamic> json) => ResponseTerms(
        resp: json["resp"],
        message: json["message"],
        termsData: List<TermsData>.from(
            json["termsData"].map((x) => TermsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "termsData": List<dynamic>.from(termsData.map((x) => x.toJson())),
      };
}

class TermsData {
  int boardIdx;
  String terms;
  String privacy;
  String insDate;
  String updDate;

  TermsData({
    required this.boardIdx,
    required this.terms,
    required this.privacy,
    required this.insDate,
    required this.updDate,
  });

  factory TermsData.fromJson(Map<String, dynamic> json) => TermsData(
        boardIdx: json["board_idx"],
        terms: json["terms"],
        privacy: json["privacy"],
        insDate: json["ins_date"],
        updDate: json["upd_date"],
      );

  Map<String, dynamic> toJson() => {
        "board_idx": boardIdx,
        "terms": terms,
        "privacy": privacy,
        "ins_date": insDate,
        "upd_date": updDate,
      };
}
