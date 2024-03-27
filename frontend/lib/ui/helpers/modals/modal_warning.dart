import 'package:flutter/material.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalWarning(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: SizedBox(
        height: 250,
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  '청소년 톡talk',
                  style: TextStyle(
                      color: ThemeColors.primary,
                      fontFamily: 'CookieRun',
                      fontWeight: FontWeight.w500),
                ),
                // TextCustom(text: ' 오류 발생', fontWeight: FontWeight.w500),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            Container(
              height: 90,
              width: 90,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [Colors.white, ThemeColors.primary])),
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ThemeColors.primary),
                child: const Icon(Icons.priority_high_rounded,
                    color: Colors.white, size: 38),
              ),
            ),
            const SizedBox(height: 35.0),
            TextCustom(
              text: text,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 20.0),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                    color: ThemeColors.primary,
                    borderRadius: BorderRadius.circular(10.0)),
                child: const TextCustom(
                    text: '확인', fontSize: 17, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
