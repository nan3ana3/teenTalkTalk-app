import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalPreparing(
  BuildContext context,
) {
  showDialog(
    useRootNavigator: true,
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: SizedBox(
        height: 220.h,
        width: 300.w,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '청소년 톡talk',
                  style: TextStyle(
                      color: ThemeColors.primary,
                      fontFamily: 'CookieRun',
                      // fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: ThemeColors.basic,
                  ),
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),
            const Divider(),
            // SizedBox(height: 10.0.h),
            Image.asset(
              'images/aco2.png',
              width: 100.w,
            ),
            // Container(
            //     padding: EdgeInsets.all(10.w),
            //     child: ),
            // SizedBox(height: 20.0.h),
            const TextCustom(
              text: '준비중입니다!',
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 20.0.h),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 100.w,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                    color: ThemeColors.primary,
                    borderRadius: BorderRadius.circular(20.0)),
                child: const TextCustom(
                  text: '확인',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
