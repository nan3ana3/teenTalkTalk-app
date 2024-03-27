import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalAccessDenied(BuildContext context, String text,
    {required VoidCallback onPressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false, // Prevent back navigation
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const TextCustom(
            text: '알림',
            fontSize: 15,
            color: ThemeColors.basic,
          ),
          content: TextCustom(
            text: text,
            fontSize: 13.sp,
            maxLines: 3,
            height: 1.h,
            fontWeight: FontWeight.w500,
          ),
          actions: <Widget>[
            TextButton(
              child: TextCustom(
                text: '확인',
                color: ThemeColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
              onPressed: () {
                Navigator.pop(context);
                onPressed();
              },
            ),
          ],
        ),
      );
    },
  );
}
