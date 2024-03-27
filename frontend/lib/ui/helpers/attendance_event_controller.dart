import 'package:get/get.dart';
import 'package:teentalktalk/domain/services/event_services.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_access_denied.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_checkLogin.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_getFig.dart';

class EventController extends GetxController {
  var week = ["일", "월", "화", "수", "목", "금", "토"];

  static DateTime now = DateTime.now();
  Rx<DateTime> now2 = DateTime.now().obs;

  RxInt year = 0.obs;
  RxInt month = 0.obs;
  RxList days = [].obs;
  RxList temp_days = [].obs;
  RxBool isCheckedAttendance = false.obs;

  @override
  void onInit() {
    super.onInit();
    setFirst(now.year, now.month);
    getAttendanceLog();
  }

  setFirst(int setYear, int setMonth) {
    year.value = setYear;
    month.value = setMonth;
    insertDays(year.value, month.value);
  }

  // 출석 기록 받아오기
  getAttendanceLog() async {
    var attendanceLog = await eventService.getAttendance();
    temp_days.value = attendanceLog.map((date) => date.day).toList();
    // print(temp_days);
  }

  // 일자 계산
  insertDays(int year, int month) {
    days.clear();

    /*
      이번달 채우기
      => 이번달의 마지막날을 구해 1일부터 마지막 날까지 추기
    */
    int lastDay = DateTime(year, month + 1, 0).day;
    for (var i = 1; i <= lastDay; i++) {
      days.add({
        "year": year,
        "month": month,
        "day": i,
        "inMonth": true,
        "picked": false.obs,
      });
    }

    /*
      이번달 1일의 요일 : DateTime(year, month, 1).weekday
      => 7이면(일요일) 상관x
      => 아니면 비어있는 요일만큼 지난달 채우기
    */
    if (DateTime(year, month, 1).weekday != 7) {
      var temp = [];
      int prevLastDay = DateTime(year, month, 0).day;
      for (var i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
        temp.add({
          "year": year,
          "month": month - 1,
          "day": prevLastDay - i,
          "inMonth": false,
          "picked": false.obs,
        });
      }
      days = [...temp, ...days].obs;
    }

    /*
      6줄을 유지하기 위해 남은 날 채우기
      => 6*7 = 42. 42개까지
    */
    var temp = [];
    for (var i = 1; i <= 42 - days.length; i++) {
      temp.add({
        "year": year,
        "month": month + 1,
        "day": i,
        "inMonth": false,
        "picked": false.obs,
      });
    }

    days = [...days, ...temp].obs;
  }

  void handleAttendanceCheck(context) {
    isCheckedAttendance.value = temp_days.contains(now2.value.day);
    // print(temp_days);
    // print(isCheckedAttendance.value);
    if (!isCheckedAttendance.value) {
      temp_days.add(now2.value.day);
      isCheckedAttendance.value = true;
      eventService.giveFigForAttendance(); // 출석체크 eid
      modalGetFig(context, '1');
    } else {
      modalAccessDenied(context, '하루에 한 번만 받을 수 있어요', onPressed: () {});
    }
  }
}
