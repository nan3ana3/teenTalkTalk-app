import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/ui/helpers/get_mobile_code_data.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_withdrawal.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});
  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  String selectedValue = '무엇이 불편하였나요?'; // 사용자가 선택한 값 저장
  String selectedCode = '';
  List<CodeDetailData> withDrawalReasonList = [];
  String otherReasonText = ''; // 기타(직접입력)

  @override
  void initState() {
    super.initState();
    withDrawalReasonList =
        getMobileCodeService.getCodeDetailList('withdrawal_reason_code');
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
                children: withDrawalReasonList.map((codeDetailData) {
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

    final isWithdrawalReasonSelected = selectedCode.isNotEmpty;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const TextCustom(
            text: '회원탈퇴',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: '청소년 톡talk을',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      TextCustom(
                        text: '탈퇴',
                        fontSize: 22.sp,
                        color: ThemeColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      TextCustom(
                        text: '하시나요?',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextCustom(
                    text: '탈퇴하시는 이유를 알려주세요.\n서비스 개선에 큰 도움이 됩니다.',
                    fontSize: 13.sp,
                    maxLines: 2,
                    color: ThemeColors.basic,
                    height: 1.4.h,
                  ),
                  SizedBox(
                    height: 30.h,
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
                              text: selectedValue.isEmpty
                                  ? '무엇이 불편하였나요?'
                                  : selectedValue,
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
                  // 기타(직접입력)일 경우에만 입력 폼을 보여줍니다.
                  if (selectedCode == '07')
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
                              maxLines: null, //자동 줄바꿈
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'NanumSquareRound'),
                              onChanged: (value) {
                                setState(() {
                                  otherReasonText = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: '기타 사유를 입력해주세요',
                                border: InputBorder.none,
                              ),
                            ),
                          )),
                    ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BtnNaru(
          margin: EdgeInsets.all(20.h),
          text: '탈퇴하기',
          width: size.width,
          height: 50.h,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          colorText: Colors.white,
          backgroundColor: isWithdrawalReasonSelected
              ? ThemeColors.primary
              : const Color.fromRGBO(217, 217, 217, 1),
          onPressed: isWithdrawalReasonSelected
              ? () {
                  // 마지막 탈퇴하시겠습니까 팝업
                  modalWithdrawal(context, selectedCode, otherReasonText);
                }
              : null, // 버튼 비활성화
        ),
      ),
    );
  }
}


// 드롭다운 버튼
                    // Center(
                    //     child: Container(
                    //   padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    //   width: size.width,
                    //   decoration: BoxDecoration(
                    //       color: ThemeColors.third,
                    //       borderRadius: BorderRadius.circular(10.r),
                    //       border: Border.all(
                    //         color: Color.fromRGBO(217, 217, 217, 1),
                    //       )),
                    //   child:

                    //   DropdownButton<String>(
                    //     value: selectedValue,
                    //     underline: Container(),
                    //     icon: const Icon(
                    //       Icons.keyboard_arrow_down_rounded,
                    //       color: ThemeColors.primary,
                    //       size: 25,
                    //     ),
                    //     isExpanded: true,
                    //     hint: TextCustom(
                    //       text: '무엇이 불편하였나요?',
                    //       fontSize: 15.sp,
                    //     ), // 선택되지 않았을 때 힌트
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         selectedValue = newValue;
                    //       });
                    //     },
                    //     items: withDrawalReasonList.map((codeDetailData) {
                    //       return DropdownMenuItem<String>(
                    //         value: codeDetailData.detailName,
                    //         child: TextCustom(
                    //           text: codeDetailData.detailName,
                    //           fontSize: 15.sp,
                    //         ),
                    //       );
                    //     }).toList(),
                    //     dropdownColor: ThemeColors.third,
                    //   ),
                    // )),