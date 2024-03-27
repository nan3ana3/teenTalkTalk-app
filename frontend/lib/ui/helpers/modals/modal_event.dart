import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/domain/services/code_service.dart';
import 'package:teentalktalk/ui/screens/user/myTalkTalk_page.dart';
import 'package:teentalktalk/ui/screens/user/my_fig_history_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalEvent(BuildContext context, {required VoidCallback onPressed}) {
  showDialog(
    useRootNavigator: true,
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: SizedBox(
        height: 200.h,
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
              '주간 무화과 챌린지',
              style: const TextStyle(
                  color: ThemeColors.primary,
                  fontFamily: 'NanumSquareRound',
                  fontSize: 28,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 5.0.h),

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
                onPressed();
              },
              child: Container(
                width: 200.w,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                    color: ThemeColors.fig_green,
                    borderRadius: BorderRadius.circular(20.0)),
                child: const TextCustom(
                  text: '참여하러 가기',
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
