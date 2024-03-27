import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teentalktalk/ui/screens/home/home_page.dart';
import 'package:teentalktalk/ui/screens/login/login_page.dart';
import 'package:teentalktalk/ui/screens/login/no_login_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalSuccessRegister(
  BuildContext context,
) {
  showDialog(
    useRootNavigator: true,
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: Container(
        // padding: EdgeInsets.all(5.h),
        height: 220.h,
        width: 280.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '청소년 톡talk',
                  style: TextStyle(
                      color: ThemeColors.primary,
                      fontFamily: 'CookieRun',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                // InkWell(
                //   child: const Icon(
                //     Icons.close_rounded,
                //     size: 20,
                //     color: ThemeColors.basic,
                //   ),
                //   onTap: () => Navigator.pop(context),
                // )
              ],
            ),
            const Divider(),
            Container(
              margin: EdgeInsets.all(15.w),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'images/namsaeng/Namsaeng1.png',
                  width: 50,
                ),
                Image.asset(
                  'images/namsaeng/Namsaeng6.png',
                  width: 50,
                ),
              ]),
            ),
            const TextCustom(
                text: '회원가입이 완료되었습니다!',
                fontSize: 17,
                fontWeight: FontWeight.w400),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  // onTap: () => Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const HomePage(),
                  //     ),
                  //     (_) => false),
                  child: Container(
                    padding: EdgeInsets.all(10.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const TextCustom(
                      text: '홈화면 이동',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // pushandremoveuntil -> loginpage 에서 뒤로가기 없애고 홈화면 이동 아이콘 추가
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));

                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const NoLoginPage()),
                    // );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.h),

                    alignment: Alignment.center,
                    // height: 35,
                    // width: 150,
                    decoration: BoxDecoration(
                        color: ThemeColors.primary,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const TextCustom(
                      text: '로그인 하기',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
