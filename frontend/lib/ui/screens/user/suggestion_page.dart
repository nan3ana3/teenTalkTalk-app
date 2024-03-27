// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:teentalktalk/domain/services/dataif_services.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_access_denied.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_basic.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_preparing.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({Key? key}) : super(key: key);

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final _keyForm = GlobalKey<FormState>();
  String title = '';
  String content = '';

  bool isButtonEnabled() {
    return title.isNotEmpty && content.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const TextCustom(
            text: '개발자와 소통하기',
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      text: '청소년 톡talk 개발자에게',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextCustom(
                      text: '여러분의 의견을 들려주세요!',
                      fontSize: 22.sp,
                      color: ThemeColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextCustom(
                            text:
                                '"이런 거 해주세요", "이런 기능이 있으면 좋겠어요" 등 여러분의 멋진\n아이디어를 자유롭게 남겨주세요!\n청소년 톡talk은 항상 사용자 의견에\n귀를 기울이고 있어요',
                            fontSize: 13.sp,
                            maxLines: 5,
                            color: ThemeColors.basic,
                            height: 1.5.h,
                          ),
                        ),
                        Image.asset(
                          'images/aco4.png',
                          width: 110.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 5.h),
                    //   child: Container(
                    //       padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    //       decoration: BoxDecoration(
                    //         // color: ThemeColors.third,
                    //         borderRadius: BorderRadius.circular(10.r),
                    //         border: Border.all(
                    //           color: const Color.fromRGBO(217, 217, 217, 1),
                    //         ),
                    //       ),
                    //       width: size.width,
                    //       height: 50.h,
                    //       child: Center(
                    //         child: TextFormField(
                    //           maxLength: 50,
                    //           validator: validatedEmail,
                    //           style: TextStyle(
                    //               fontSize: 15.sp,
                    //               fontFamily: 'NanumSquareRound'),
                    //           onChanged: (value) {
                    //             setState(() {
                    //               email = value;
                    //             });
                    //           },
                    //           decoration: InputDecoration(
                    //               hintText: '답변 받으실 이메일을 입력해주세요',
                    //               border: InputBorder.none,
                    //               counterText: '',
                    //               errorStyle: TextStyle(
                    //                   color: ThemeColors.primary,
                    //                   fontSize: 8.sp),
                    //               contentPadding:
                    //                   EdgeInsets.symmetric(vertical: 0.2.h)),
                    //         ),
                    //       )),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: const Color.fromRGBO(217, 217, 217, 1),
                            ),
                          ),
                          width: size.width,
                          height: 50.h,
                          child: Center(
                            child: TextFormField(
                              maxLength: 50,
                              validator:
                                  RequiredValidator(errorText: '* 제목을 작성해주세요'),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'NanumSquareRound'),
                              onChanged: (value) {
                                setState(() {
                                  title = value;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: '제목을 작성해주세요',
                                  border: InputBorder.none,
                                  counterText: '',
                                  errorStyle: TextStyle(
                                      color: ThemeColors.primary,
                                      fontSize: 8.sp),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0.2.h)),
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 12.0.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: const Color.fromRGBO(217, 217, 217, 1),
                            ),
                          ),
                          width: size.width,
                          height: 200.h,
                          child: SingleChildScrollView(
                            child: TextFormField(
                              maxLength: 200,
                              validator:
                                  RequiredValidator(errorText: '* 내용을 작성해주세요'),
                              maxLines: null, //자동 줄바꿈
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'NanumSquareRound'),
                              onChanged: (value) {
                                setState(() {
                                  content = value;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: '내용을 작성해주세요',
                                  border: InputBorder.none,
                                  errorStyle: TextStyle(
                                      color: ThemeColors.primary,
                                      fontSize: 8.sp),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0.2.h)),
                            ),
                          )),
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Checkbox(
                    //           value: isEmailAgreed,
                    //           onChanged: (value) {
                    //             setState(() {
                    //               isEmailAgreed = value!;
                    //             });
                    //           },
                    //           activeColor: ThemeColors.primary,
                    //         ),
                    //         TextCustom(
                    //           text: '이메일 정보 제공 동의',
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 13.sp,
                    //         ),
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         SizedBox(
                    //           width: 45.w,
                    //         ),
                    //         TextCustom(
                    //           text: '질문에 대한 답변을 받으려면\n이메일 정보 제공에 동의해주세요.',
                    //           maxLines: 2,
                    //           color: ThemeColors.basic,
                    //           fontSize: 13.sp,
                    //           height: 1.3,
                    //         )
                    //       ],
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BtnNaru(
            margin: EdgeInsets.all(20.h),
            text: '이메일 보내기',
            width: size.width,
            height: 50.h,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            colorText: Colors.white,
            backgroundColor: isButtonEnabled()
                ? ThemeColors.primary
                : const Color.fromRGBO(217, 217, 217, 1),
            onPressed: () async {
              if (_keyForm.currentState!.validate()) {
                final response =
                    await dataIfService.sendSuggestionEmail(title, content);
                if (response.resp) {
                  modalAccessDenied(context, '소중한 의견 감사합니다.', onPressed: () {
                    Navigator.pop(context);
                  });
                } else {}
              }
            }),
      ),
    );
  }
}
