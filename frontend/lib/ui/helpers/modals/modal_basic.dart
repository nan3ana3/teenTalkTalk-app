import 'package:flutter/material.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalBasic(
  BuildContext context,
  String text,
) {
  showDialog(
    useRootNavigator: true,
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: SizedBox(
        height: 200,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '청소년 톡talk',
                  style: TextStyle(
                      color: ThemeColors.primary,
                      fontFamily: 'CookieRun',
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                    child: const Icon(
                      Icons.close_rounded,
                      color: ThemeColors.basic,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            const Divider(),
            const SizedBox(height: 40.0),
            TextCustom(text: text, fontSize: 17, fontWeight: FontWeight.w400),
            const SizedBox(height: 40.0),
            BtnNaru(
              text: '확인',
              fontSize: 20,
              height: 35,
              width: 150,
              onPressed: () => Navigator.pop(context),
            ),

            // Container(
            //   height: 90,
            //   width: 90,
            //   decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       gradient: LinearGradient(
            //           begin: Alignment.centerLeft,
            //           colors: [Colors.white, Colors.green])),
            //   child: Container(
            //     margin: const EdgeInsets.all(10.0),
            //     decoration: const BoxDecoration(
            //         shape: BoxShape.circle, color: Colors.green),
            //     child: const Icon(Icons.check, color: Colors.white, size: 38),
            //   ),
            // ),
            // const SizedBox(height: 35.0),

            // GestureDetector(
            //   onTap: onPressed,
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: 35,
            //     width: 150,
            //     decoration: BoxDecoration(
            //         color: Colors.green,
            //         borderRadius: BorderRadius.circular(10.0)),
            //     child: const TextCustom(
            //         text: '확인', color: Colors.white, fontSize: 17),
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}
