// import 'package:flutter/animation.dart'

import 'package:teentalktalk/domain/models/response/response_event.dart';
import 'package:teentalktalk/domain/services/code_service.dart';

class CodeDetailData {
  final String detailName;
  final String code;
  final String codeName;
  bool selected;
  CodeDetailData(
      {required this.detailName,
      required this.code,
      required this.codeName,
      this.selected = false});
}

// class CodeData {
//   final String? codeName;
//   final List<CodeDetailData>? detailList;
//   CodeData({this.codeName, this.detailList});
// }

class getMobileCodeFunctions {
  late Map<String, dynamic> codeData = {};
  late List<EventData> eventData = [];

  void getCodeData() async {
    var data = await codeService.getCodeData();
    codeData = data;
    // print(codeData['codes']['withdrawal_reason_code']);
  }

  void getEventData() async {
    ResponseEvent EventData = await codeService.getEventData();
    eventData = EventData.eventData;
    // print(eventData);
    // return eventData;
  }

/*
호출 예시
1. getCodeDetailName(예 : '적용 대상' 코드 '00' 값 이름 -> 'policy_tareget_code', 코드 값 전달 -> '부부/임산부' 반환)
getMobileCodeService.getCodeDetailName('policy_target_code', policies.policy_target_code);

2. getCodeDetailList(예 : '운영 기관' -> 'policy_institution_code' 전달 -> 리스트 반환 [['00', '영암군'], ['01', '청소년 수련관']...])
getMobileCodeService.getCodeDetailList('policy_institution_code');
*/

  String getCodeDetailName(String myCodeName, String myCodeDetail) {
    // print(codeData);
    int indexCode = int.parse(myCodeDetail);
    String codeDetailName =
        codeData["codes"][myCodeName][indexCode]["code_detail_name"];
    return codeDetailName;
  }

  List<CodeDetailData> getCodeDetailList(String myCodeName) {
    List<dynamic> codeDetailList = codeData["codes"][myCodeName];
    List<CodeDetailData> result = [];
    for (var detail in codeDetailList) {
      CodeDetailData codeDetail = CodeDetailData(
        detailName: detail["code_detail_name"],
        code: detail["code_detail"],
        codeName: myCodeName,
      );
      result.add(codeDetail);
    }
    return result;
  }

  // 이벤트 코드 풀 끊김 해결

  List<EventData> getEventDetail(String eid) {
    List<EventData> matchingEvents = [];
    for (var event in eventData) {
      if (event.eid == eid) {
        matchingEvents.add(event);
      }
    }
    return matchingEvents;
  }
}

final getMobileCodeService = getMobileCodeFunctions();
