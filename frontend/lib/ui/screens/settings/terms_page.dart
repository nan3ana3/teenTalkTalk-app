import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/ui/screens/register/terms_detail_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class ServiceTermsPage extends StatelessWidget {
  const ServiceTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const TextCustom(
                text: '서비스 이용약관',
                color: ThemeColors.basic,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ThemeColors.primary,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SafeArea(
              child: Column(children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 30, right: 30),
                  title: TextCustom(
                    text: "회원가입 이용 약관",
                    fontSize: 18.sp,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: ThemeColors.basic,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const termsDetailPage(
                            termsCode: 0,
                          ),
                        ));
                  },
                ),
                Container(
                  height: 1.h,
                  color: Colors.grey[200],
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 30, right: 30),
                  title: TextCustom(
                    text: "개인 정보 처리 방침",
                    fontSize: 18.sp,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: ThemeColors.basic,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const termsDetailPage(
                            termsCode: 1,
                          ),
                        ));
                  },
                ),
                Container(
                  height: 1.h,
                  color: Colors.grey[200],
                ),
              ]),
            )));
  }
}
