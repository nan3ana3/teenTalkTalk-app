import 'package:flutter/material.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalSuccess(BuildContext context, String text,
    {required VoidCallback onPressed}) {
  showDialog(
    useRootNavigator: true,
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: SizedBox(
        height: 250,
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  '청소년 톡talk',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'CookieRun',
                      fontWeight: FontWeight.w500),
                ),
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
                      colors: [Colors.white, Colors.green])),
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
                child: const Icon(Icons.check, color: Colors.white, size: 38),
              ),
            ),
            const SizedBox(height: 35.0),
            TextCustom(text: text, fontSize: 17, fontWeight: FontWeight.w400),
            const SizedBox(height: 20.0),
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

            InkWell(
              onTap: () {
                Navigator.pop(context);
                onPressed();
              },
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0)),
                child: const TextCustom(
                    text: '확인', color: Colors.white, fontSize: 17),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
