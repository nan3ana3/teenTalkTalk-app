import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/domain/services/auth_services.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_success_register.dart';
import 'package:teentalktalk/ui/screens/home/home_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

class InfoInputPage extends StatefulWidget {
  const InfoInputPage({required this.userTypeCode, Key? key}) : super(key: key);
  final int userTypeCode;

  @override
  State<InfoInputPage> createState() => _InfoInputPageState();
}

class _InfoInputPageState extends State<InfoInputPage> {
  late ScrollController _scrollController;

  late TextEditingController userIDController;
  late TextEditingController userPWController;
  late TextEditingController userAgainPWController;
  late TextEditingController userEmailController;
  late TextEditingController userNameController;
  // late TextEditingController inviteCodeController;
  // late TextEditingController userPhoneNumberController;
  late int userTypeCode; // 사용자 유형
  final String userRole = '0';
  String? emd;
  String? youthAge;
  String? parentsAge;
  String? sex;

  final _keyForm = GlobalKey<FormState>();
  late bool isDuplicate = true;
  List<CodeDetailData> youthAgeList = [];
  List<CodeDetailData> parentsAgeList = [];
  List<CodeDetailData> sexList = [];
  List<CodeDetailData> emdList = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    userIDController = TextEditingController();
    userPWController = TextEditingController();
    userAgainPWController = TextEditingController();
    userEmailController = TextEditingController();
    userNameController = TextEditingController();
    // inviteCodeController = TextEditingController();
    // userPhoneNumberController = TextEditingController();
    // emd = '0';
    // youthAge = '5';
    // parentsAge = '6';
    // sex = '2';
    youthAgeList = getMobileCodeService.getCodeDetailList('youthAge_code');
    parentsAgeList = getMobileCodeService.getCodeDetailList('parentsAge_code');
    sexList = getMobileCodeService.getCodeDetailList('sex_class_code');
    emdList = getMobileCodeService.getCodeDetailList('emd_class_code');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    userIDController.dispose();
    userPWController.dispose();
    userAgainPWController.dispose();
    userEmailController.dispose();
    userNameController.dispose();
    // inviteCodeController.dispose();
    // userPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userTypeCode = widget.userTypeCode;
    // emdList2.forEach((codeDetail) {
    //   print(
    //       'detailName: ${codeDetail.detailName}, code: ${codeDetail.code}, codeName: ${codeDetail.codeName}, selected: ${codeDetail.selected}');
    // });
    // print('user type code - $userTypeCode');
    final size = MediaQuery.of(context).size;

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        print(state);
        // if (state is LoadingUserState) {
        //   modalLoading(context, '로드 중');
        //   Navigator.pop(context);
        // } else

        if (state is SuccessUserState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (_) => false);
          modalSuccessRegister(
            context,
          );
          // modalSuccess(
          //   context,
          //   '회원가입이 완료되었습니다',
          //   onPressed: () => Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const HomePage(),
          //       ),
          //       (_) => false),
          // );
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(
                        text: '회원가입',
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.black),
                    const SizedBox(height: 50.0),
                    const TextCustom(
                      text: '아이디를 입력해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width / 1.5,
                          child: TextFieldNaru(
                            controller: userIDController,
                            hintText: '아이디',
                            validator:
                                RequiredValidator(errorText: '아이디를 입력해주세요'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: BtnNaru(
                            text: '중복확인',
                            fontSize: 15,
                            width: size.width / 5,
                            height: 40,
                            colorText: Colors.white,
                            onPressed: () async {
                              if (userIDController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: TextCustom(
                                      text: '아이디를 입력해주세요',
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                isDuplicate = await authService
                                    .checkDuplicateID(userIDController.text);
                                // print(isDuplicate);

                                if (isDuplicate) {
                                  // 중복 아이디가 존재하는 경우
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: TextCustom(
                                        text: '이미 존재하는 아이디입니다.',
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  // 중복 아이디가 존재하지 않는 경우
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: TextCustom(
                                        text: '사용 가능한 아이디입니다.',
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '비밀번호를 입력해주세요.',
                      fontSize: 17,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    TextFieldNaru(
                      controller: userPWController,
                      hintText: '8자리 이상 입력',
                      isPassword: true,
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 10.0),
                    TextFieldNaru(
                      controller: userAgainPWController,
                      hintText: '비밀번호 확인',
                      isPassword: true,
                      validator:
                          //againpasswordValidator,
                          (value) {
                        if (value!.isEmpty) {
                          return '비밀번호 확인을 입력해주세요.';
                        }
                        return ConfirmPasswordValidator.validate(
                          userPWController.text,
                          value,
                        );
                      },
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '이름을 입력해주세요.',
                      fontSize: 17,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    TextFieldNaru(
                      controller: userNameController,
                      hintText: '이름',
                      validator: RequiredValidator(errorText: '이름을 입력해주세요.'),
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '이메일을 입력해주세요.',
                      fontSize: 17,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    TextFieldNaru(
                      controller: userEmailController,
                      hintText: '이메일',
                      keyboardType: TextInputType.emailAddress,
                      validator: validatedEmail,
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                        text: '추가 정보 입력',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Colors.black),
                    const SizedBox(height: 10.0),
                    const TextCustom(
                        text: '필수가 아닌 항목입니다.',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black),
                    // const SizedBox(height: 40.0),
                    // 친구 초대
                    // const TextCustom(
                    //   text: '친구 초대 코드를 입력해주세요.',
                    //   fontSize: 17,
                    //   maxLines: 2,
                    // ),
                    // // const SizedBox(height: 1.0),
                    // TextFieldNaru(
                    //   controller: inviteCodeController,
                    //   hintText: '친구 초대 코드',
                    //   // validator: RequiredValidator(errorText: '이름을 입력해주세요.'),
                    // ),
                    const SizedBox(height: 40.0),

                    // // 전화번호
                    // const TextCustom(
                    //   text: '전화번호를 입력해주세요.',
                    //   fontSize: 17,
                    //   letterSpacing: 1.0,
                    //   maxLines: 2,
                    // ),
                    // const SizedBox(height: 1.0),
                    // TextFormField(
                    //   keyboardType: TextInputType.phone,
                    //   maxLength: 13,
                    //   inputFormatters: [
                    //     FilteringTextInputFormatter.digitsOnly, //숫자만!
                    //     NumberFormatter(), // 자동하이픈
                    //     LengthLimitingTextInputFormatter(13),
                    //     //13자리만 입력받도록 하이픈 2개+숫자 11개
                    //   ],
                    //   // controller: userPhoneNumberController,
                    //   // ignore: prefer_const_constructors
                    //   decoration: InputDecoration(
                    //     // ignore: prefer_const_constructors
                    //     icon: Icon(
                    //       Icons.phone_iphone,
                    //       color: ThemeColors.primary,
                    //     ),
                    //     hintText: "010-xxxx-xxxx",
                    //     focusedBorder: const UnderlineInputBorder(
                    //       borderSide: BorderSide(color: ThemeColors.primary),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 15.0),

                    // 거주지
                    const TextCustom(
                      text: '거주지를 선택해주세요.',
                      fontSize: 17,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const TextCustom(
                          text: '영암군    ',
                          fontSize: 17,
                          color: ThemeColors.basic,
                          maxLines: 2,
                        ),
                        DropdownButton<String>(
                          value: emdList
                              .firstWhere((element) => element.selected,
                                  orElse: () => emdList[0])
                              .detailName,
                          items: emdList.map((value) {
                            return DropdownMenuItem(
                              value: value.detailName,
                              child: TextCustom(
                                text: value.detailName,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              for (var element in emdList) {
                                element.selected = false;
                              }
                              emdList
                                  .firstWhere(
                                      (element) => element.detailName == value,
                                      orElse: () => emdList[0])
                                  .selected = true;
                              emd = emdList
                                  .firstWhere((element) => element.selected,
                                      orElse: () => emdList[0])
                                  .code;
                            });
                            // print('emd - selected : ' + emd);
                          },
                          focusColor: ThemeColors.primary,
                          borderRadius: BorderRadius.circular(4.0),
                          elevation: 4,
                        )
                      ],
                    ),
                    const SizedBox(height: 40.0),

                    // 재학여부(청소년 0, 청소년부모 1) / 나이(부모 2)
                    // AgeToggleButton(userTypeCode), // 토글버튼 클래스
                    if (userTypeCode == 0 || userTypeCode == 1) ...[
                      const TextCustom(
                        text: '재학 여부를 선택해주세요.',
                        fontSize: 17,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10.0),
                      ToggleSwitch(
                        minWidth: (size.width - 80) / 6,
                        minHeight: 50.0,
                        fontSize: size.width / 45,
                        // multiLineText: true,
                        initialLabelIndex: 5,
                        activeBgColor: const [ThemeColors.third],
                        activeFgColor: Colors.black,
                        inactiveBgColor: Colors.white,
                        borderColor: const [Color.fromARGB(255, 184, 183, 183)],
                        borderWidth: 0.45,
                        activeBorders: [
                          Border.all(
                            color: ThemeColors.primary,
                            width: 1,
                          )
                        ],
                        dividerColor: const Color.fromARGB(255, 184, 183, 183),
                        totalSwitches: 6,
                        labels: youthAgeList.map((data) {
                          if (data.detailName.length > 3) {
                            return '${data.detailName.substring(0, 2)}\n${data.detailName.substring(2)}';
                          } else {
                            return data.detailName;
                          }
                        }).toList(),
                        animate: true,
                        animationDuration: 200,
                        cornerRadius: 7,
                        onToggle: (index) {
                          print('school - switched to : $index');
                          youthAge = youthAgeList[index!].code;
                          parentsAge = '6'; // 선택안함
                        },
                      ),
                    ] else if (userTypeCode == 2) ...[
                      const TextCustom(
                        text: '나이를 선택해주세요.',
                        fontSize: 17,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10.0),
                      ToggleSwitch(
                        minWidth: (size.width - 80) / 7,
                        minHeight: 50.0,
                        fontSize: size.width / 45,
                        initialLabelIndex: 6,
                        activeBgColor: const [ThemeColors.third],
                        activeFgColor: Colors.black,
                        inactiveBgColor: Colors.white,
                        borderColor: const [Color.fromARGB(255, 184, 183, 183)],
                        borderWidth: 0.45,
                        activeBorders: [
                          Border.all(
                            color: ThemeColors.primary,
                            width: 1,
                          )
                        ],
                        dividerColor: const Color.fromARGB(255, 184, 183, 183),
                        totalSwitches: 7,
                        labels: parentsAgeList.map((data) {
                          if (data.detailName.length > 3) {
                            return '${data.detailName.substring(0, 3)}\n${data.detailName.substring(3)}';
                          } else {
                            return data.detailName;
                          }
                        }).toList(),
                        animate: true,
                        animationDuration: 200,
                        cornerRadius: 7,
                        onToggle: (index) {
                          print('age - switched to : $index');
                          parentsAge = parentsAgeList[index!].code;
                          youthAge = '5'; // 선택안함
                        },
                      )
                    ],

                    const SizedBox(height: 40.0),

                    // 성별
                    // const SexToggleButton(),
                    const TextCustom(
                      text: '성별을 선택해주세요.',
                      fontSize: 17,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10.0),
                    ToggleSwitch(
                      minWidth: (size.width - 80) / 3,
                      minHeight: 50.0,
                      fontSize: 15,
                      initialLabelIndex: 2,
                      activeBgColor: const [ThemeColors.third],
                      activeFgColor: Colors.black,
                      inactiveBgColor: Colors.white,
                      borderColor: const [Color.fromARGB(255, 184, 183, 183)],
                      borderWidth: 0.45,
                      activeBorders: [
                        Border.all(
                          color: ThemeColors.primary,
                          width: 1,
                        )
                      ],
                      dividerColor: const Color.fromARGB(255, 184, 183, 183),
                      totalSwitches: 3,
                      labels: sexList.map((data) => data.detailName).toList(),
                      animate: true,
                      animationDuration: 200,
                      cornerRadius: 7,
                      onToggle: (index) {
                        print('sex - switched to : $index');

                        sex = sexList[index!].code;
                      },
                    ),

                    const SizedBox(height: 60.0),
                    BtnNaru(
                        text: '회원가입하기',
                        width: size.width,
                        colorText: Colors.white,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          // print(userRole);
                          // print(userTypeCode);
                          // print(youthAge);
                          // print(parentsAge);
                          // print(emd);
                          // print(sex);

                          if (isDuplicate) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: TextCustom(
                                  text: '아이디 중복 체크를 해주세요',
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (_keyForm.currentState != null &&
                              _keyForm.currentState!.validate()) {
                            // String inviteCode = '';
                            // inviteCode = inviteCodeController.text.trim();

                            String _youthAge = youthAge ?? '5';
                            String _parentsAge = parentsAge ?? '6';
                            String _emd = emd ?? '0';
                            String _sex = sex ?? '2';

                            // print(_youthAge);
                            // print(_parentsAge);
                            // print(_youthAge);
                            // print(_emd);
                            // print(_sex);

                            userBloc.add(OnRegisterUserEvent(
                                userIDController.text.trim(),
                                userNameController.text.trim(),
                                userEmailController.text.trim(),
                                userPWController.text.trim(),
                                userAgainPWController.text.trim(),
                                userRole, // user_role - 사용자
                                userTypeCode.toString(), // user_type
                                // inviteCode,
                                // userPhoneNumberController.text.trim(),
                                _youthAge, // youthAge_code
                                _parentsAge, // parentsAge_code
                                _emd, //emd_class_code
                                _sex // sex_class_code
                                ));
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmPasswordValidator {
  static String? validate(String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return "비밀번호가 일치하지 않습니다.";
    }
    return null;
  }
}

// 핸드폰 번호 입력
class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
