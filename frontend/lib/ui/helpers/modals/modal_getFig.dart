import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:teentalktalk/domain/models/response/response_event.dart';
import 'package:teentalktalk/domain/models/response/response_event.dart';
import 'package:teentalktalk/domain/services/code_service.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/ui/screens/user/myTalkTalk_page.dart';
import 'package:teentalktalk/ui/screens/user/my_fig_history_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalGetFig(BuildContext context, String eid) {
  List<EventData> matchingEvents = getMobileCodeService.getEventDetail(eid);

  String message = '';
  String figPayment = '';

  if (matchingEvents.isNotEmpty) {
    figPayment = matchingEvents[0].fig_payment.toString();
  }

  switch (eid) {
    case '1':
      message = '출석체크 완료';
      break;
    case '2':
      message = '웰컴 청소년 톡talk';
      break;
    case '3':
      message = '정책 스크랩 완료';
      break;
    case '4':
      message = '정책 공유 완료';
      break;
    case '5':
      message = '친구 초대 완료';
      break;
    case '6':
      message = '초대 코드 입력 완료';
      break;
    default:
      message = '';
  }

  showDialog(
    useRootNavigator: true,
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: SizedBox(
        height: 220.h,
        width: 300.w,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    child: const Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: ThemeColors.basic,
                    ),
                    onTap: () => Navigator.pop(context))
              ],
            ),
            // SizedBox(height: 10.0.h),
            Text(
              message,
              style: const TextStyle(
                  color: ThemeColors.primary,
                  fontFamily: 'NanumSquareRound',
                  fontSize: 28,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 5.0.h),
            TextCustom(
              text: '무화과 $figPayment개 획득',
              fontWeight: FontWeight.bold,
            ),
            Container(
              padding: EdgeInsets.all(10.h),
              child: Image.asset(
                'images/Fig2.png',
                width: 80.w,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyFigHistoryPage(),
                    ));
              },
              child: Container(
                width: 200.w,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                    color: ThemeColors.fig_green,
                    borderRadius: BorderRadius.circular(20.0)),
                child: const TextCustom(
                  text: '내 무화과 확인하기',
                  color: ThemeColors.basic,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
