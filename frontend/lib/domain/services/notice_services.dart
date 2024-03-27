import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/env/env.dart';
import 'package:teentalktalk/domain/models/response/response_notice.dart';

class NoticeServices {
  Map<String, String> _setHeaders() =>
      {'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8'};

  Future<List<Notice>> getNoticeData() async {
    // print('get banner data');
    final resp = await http.get(Uri.parse('${Environment.urlApi}/main/notice'),
        headers: _setHeaders());
    print(resp.body);

    return ResponseNotice.fromJson(jsonDecode(resp.body)).notices;
  }
}

final noticeService = NoticeServices();
