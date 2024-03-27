import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:teentalktalk/domain/services/dataif_services.dart';
import 'package:teentalktalk/ui/helpers/get_mobile_code_data.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_access_denied.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_success.dart';
import 'package:teentalktalk/ui/helpers/validate_form.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class ServiceCenterPage extends StatefulWidget {
  const ServiceCenterPage({super.key});
  @override
  State<ServiceCenterPage> createState() => _ServiceCenterPageState();
}

class _ServiceCenterPageState extends State<ServiceCenterPage> {
  final _keyForm = GlobalKey<FormState>();
  String selectedValue = '질문 유형을 선택해주세요'; // 사용자가 선택한 값 저장
  String selectedCode = '';
  List<CodeDetailData> questionTypeList = [];
  String content = ''; // 기타(직접입력)
  String email = '';
  bool isEmailAgreed = false;

  @override
  void initState() {
    super.initState();
    questionTypeList =
        getMobileCodeService.getCodeDetailList('question_type_code');
  }

  void _showDropdown(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.minPositive,
            child: SingleChildScrollView(
              child: ListBody(
                children: questionTypeList.map((codeDetailData) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedValue = codeDetailData.detailName;
                        selectedCode = codeDetailData.code;
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Text(codeDetailData.detailName),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isQuestionTypeSelected = selectedCode.isNotEmpty;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const TextCustom(
            text: '고객 센터',
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
                      text: '청소년 톡talk',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextCustom(
                      text: '무엇이든 물어보세요',
                      fontSize: 22.sp,
                      color: ThemeColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextCustom(
                      text:
                          '휴일을 제외한 평일에는 24시간 이내에 답변 드립니다.\n24시간이 지나도 답변이 오지 않는다면,\n스팸 메일함을 확인해주세요.',
                      fontSize: 13.sp,
                      maxLines: 3,
                      color: ThemeColors.basic,
                      height: 1.4.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                          decoration: BoxDecoration(
                            // color: ThemeColors.third,
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
                              validator: validatedEmail,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'NanumSquareRound'),
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: '답변 받으실 이메일을 입력해주세요',
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
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () => _showDropdown(context),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                              color: ThemeColors.third,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: const Color.fromRGBO(217, 217, 217, 1),
                              )),
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextCustom(
                                text: selectedValue,
                                fontSize: 15.sp,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: ThemeColors.primary,
                                size: 25,
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 12.0.h),
                          decoration: BoxDecoration(
                            // color: ThemeColors.third,
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
                                  RequiredValidator(errorText: '* 필수 입력 사항입니다'),
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
                                      fontSize: 10.sp),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0.2.h)),
                            ),
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: isEmailAgreed,
                              onChanged: (value) {
                                setState(() {
                                  isEmailAgreed = value!;
                                });
                              },
                              activeColor: ThemeColors.primary,
                            ),
                            TextCustom(
                              text: '이메일 정보 제공 동의',
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 45.w,
                            ),
                            TextCustom(
                              text: '질문에 대한 답변을 받으려면\n이메일 정보 제공에 동의해주세요.',
                              maxLines: 2,
                              color: ThemeColors.basic,
                              fontSize: 13.sp,
                              height: 1.3,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BtnNaru(
          margin: EdgeInsets.all(20.h),
          text: '질문 보내기',
          width: size.width,
          height: 50.h,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          colorText: Colors.white,
          backgroundColor: isQuestionTypeSelected && isEmailAgreed
              ? ThemeColors.primary
              : const Color.fromRGBO(217, 217, 217, 1),
          onPressed: () async {
            if (isQuestionTypeSelected && isEmailAgreed) {
              if (_keyForm.currentState!.validate()) {
                final response = await dataIfService.submitInquiry(
                    email, selectedCode, content);
                if (response.resp) {
                  // ignore: use_build_context_synchronously
                  modalAccessDenied(context, "문의사항이 성공적으로 등록되었습니다.",
                      onPressed: () {
                    Navigator.pop(context);
                  });
                } else {}
              }
            } else {
              modalAccessDenied(context, '질문 유형을 선택하고 이메일 정보 제공에 동의해주세요',
                  onPressed: () {});
            }
          },
        ),
      ),
    );
  }
}
