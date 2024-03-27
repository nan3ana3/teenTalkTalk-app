import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/env/env.dart';
import 'package:teentalktalk/data/storage/secure_storage.dart';
import 'package:teentalktalk/domain/models/response/default_response.dart';
import 'package:teentalktalk/domain/models/response/response_terms.dart';

class DataIfServices {
  // 공지사항 불러오기

  // 사용자 문의사항 등록
  Future<DefaultResponse> submitInquiry(
      String email, String code, String content) async {
    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/dataif/submit-inquiry'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'inquiry_type_code': code, 'content': content});
    // print(resp.body);
    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  // 이용약관 정보 가져오기
  Future<ResponseTerms> getTermsData() async {
    final resp = await http.get(Uri.parse('${Environment.urlApi}/dataif/terms'),
        headers: {'Accept': 'application/json'});
    // print(resp.body);

    return ResponseTerms.fromJson(jsonDecode(resp.body));
  }

  // 사용자 개발 제안 메일 보내기
  Future<DefaultResponse> sendSuggestionEmail(
      String title, String content) async {
    final resp = await http
        .post(Uri.parse('${Environment.urlApi}/dataif/suggestion'), headers: {
      'Accept': 'application/json',
    }, body: {
      'title': title, // 제목
      'content': content, // 내용
    });
    // print(resp.body);
    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }
}

final dataIfService = DataIfServices();
