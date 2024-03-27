import 'package:flutter/material.dart';
import 'package:teentalktalk/ui/screens/register/info_input_page.dart';
import 'package:teentalktalk/ui/screens/register/kakao_extra_info_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class userTypePage extends StatelessWidget {
  const userTypePage({required this.isKakaoLogin, Key? key}) : super(key: key);
  final bool isKakaoLogin;

  @override
  Widget build(BuildContext context) {
    // print(isKakaoLogin);
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: ThemeColors.primary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
            child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: size.width,
            child: Row(
                // children: [
                //   Image.asset('assets/img/yeongam_logo.jpeg', height: 30),
                // ],
                ),
          ),

          const TextCustom(
            text: '회원가입',
            letterSpacing: 2.0,
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),

          const SizedBox(
            height: 25.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextCustom(
              text: ('회원 유형에 따라 가입 절차가 다르니\n본인에 해당하는 회원 유형을 선택해주세요.'),
              textAlign: TextAlign.center,
              maxLines: 2,
              fontSize: 17,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SizedBox(
              height: 80,
              width: size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent, //ThemeColors.primary,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: ThemeColors.primary, // your color here
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      TextCustom(
                          text: '청소년',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      TextCustom(
                          text: '24세 이하', color: Colors.black, fontSize: 15),
                    ],
                  ),
                ),
                onPressed: () => isKakaoLogin
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KakaoExtraInfoPage(
                            userTypeCode: 0,
                          ),
                        ))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InfoInputPage(
                            userTypeCode: 0,
                          ),
                        )),
              ),
            ),
          ),

          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SizedBox(
              height: 80,
              width: size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent, //ThemeColors.primary,
                    // surfaceTintColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: ThemeColors.primary, // your color here
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(30.0))),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      TextCustom(
                          text: '청소년부모',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      TextCustom(
                          text: '24세 이하의\n청소년 부모',
                          maxLines: 2,
                          color: Colors.black,
                          height: 1.5,
                          textAlign: TextAlign.right,
                          fontSize: 15),
                    ],
                  ),
                ),
                onPressed: () => isKakaoLogin
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KakaoExtraInfoPage(
                            userTypeCode: 1,
                          ),
                        ))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InfoInputPage(
                            userTypeCode: 1,
                          ),
                        )),
              ),
            ),
          ),

          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SizedBox(
                height: 80,
                width: size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, //ThemeColors.primary,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: ThemeColors.primary, // your color here
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(30.0))),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        TextCustom(
                            text: '학부모',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                        TextCustom(
                            text: '자녀를 둔\n25세 이상의 학부모',
                            maxLines: 2,
                            textAlign: TextAlign.right,
                            height: 1.5,
                            color: Colors.black,
                            fontSize: 15),
                      ],
                    ),
                  ),
                  onPressed: () => isKakaoLogin
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KakaoExtraInfoPage(
                              userTypeCode: 2,
                            ),
                          ))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InfoInputPage(
                              userTypeCode: 2,
                            ),
                          )),
                )),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //   child: SizedBox(
          //     height: 50,
          //     width: size.width,
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //           backgroundColor: Colors.amber[100],
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(12.0))),
          //       child: const TextCustom(
          //           text: '부모', color: Colors.black, fontSize: 20),
          //       onPressed: () => Navigator.push(
          //           context, routeSlide(page: const RegisterPage())),
          //     ),
          //   ),
          // ),
        ])));
  }
}
