import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/env/env.dart';
import 'package:teentalktalk/domain/models/response/default_response.dart';
import 'package:teentalktalk/domain/models/response/response_event.dart';

class codeServices {
  Map<String, String> _setHeaders() =>
      {'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8'};

  //Future<List<commonCode>>
  getCodeData() async {
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/codeData/get-code-data'),
        headers:
            _setHeaders()); // {'Accept': 'application/json'}); //, 'xxx-token': token!});
    var result = jsonDecode(resp.body);
    return result;
  }

  // 이벤트 정보 불러오기

  Future<ResponseEvent> getEventData() async {
    // print('getEventData');
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/codeData/get-event-data'),
        headers: {'Accept': 'application/json'});
    // print(resp.body);

    return ResponseEvent.fromJson(jsonDecode(resp.body));
  }
}

final codeService = codeServices();
