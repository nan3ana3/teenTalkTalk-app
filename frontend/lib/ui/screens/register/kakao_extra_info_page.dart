import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/ui/helpers/kakao_sdk_login.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_success_register.dart';
import 'package:teentalktalk/ui/screens/home/home_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoExtraInfoPage extends StatefulWidget {
  const KakaoExtraInfoPage({
    required this.userTypeCode,
    Key? key,
  }) : super(key: key);
  final int userTypeCode;

  @override
  State<KakaoExtraInfoPage> createState() => _KakaoExtraInfoPageState();
}

class _KakaoExtraInfoPageState extends State<KakaoExtraInfoPage> {
  final String userRole = '0';
  String? emd;
  String? youthAge;
  String? parentsAge;
  String? sex;

  // final _keyForm = GlobalKey<FormState>();
  late bool isDuplicate = true;
  List<CodeDetailData> youthAgeList = [];
  List<CodeDetailData> parentsAgeList = [];
  List<CodeDetailData> sexList = [];
  List<CodeDetailData> emdList = [];
  late String user_id = '';
  late String user_name = '';
  late String user_email = '';

  @override
  void initState() {
    super.initState();
    KakaoLoginServices.kakaoGetUserInfo().then((userInfo) {
      setState(() {
        user_id = userInfo['user_id'] ?? '';
        user_name = userInfo['user_name'] ?? '';
        user_email = userInfo['user_email'] ?? '';
      });
    });
    youthAgeList = getMobileCodeService.getCodeDetailList('youthAge_code');
    parentsAgeList = getMobileCodeService.getCodeDetailList('parentsAge_code');
    sexList = getMobileCodeService.getCodeDetailList('sex_class_code');
    emdList = getMobileCodeService.getCodeDetailList('emd_class_code');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int userTypeCode = widget.userTypeCode;
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          print('kakao info page');
          print(state);
          // if (state is LoadingUserState) {
          //   modalLoading(context, '로드 중');
          //   Navigator.pop(context);
          // } else

          if (state is SuccessKakaoUserState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (_) => false);
            modalSuccessRegister(
              context,
            );
          } else if (state is FailureUserState) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              routeFade(page: const HomePage()),
              (_) => false,
            );
            errorMessageSnack(context, state.error);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const TextCustom(
              text: '회원가입',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: ThemeColors.primary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextCustom(
                        text: '추가 정보 입력',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 30,
                      ), // 친구 초대

                      const SizedBox(height: 40.0),

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
                                        (element) =>
                                            element.detailName == value,
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
                          borderColor: const [
                            Color.fromARGB(255, 184, 183, 183)
                          ],
                          borderWidth: 0.45,
                          activeBorders: [
                            Border.all(
                              color: ThemeColors.primary,
                              width: 1,
                            )
                          ],
                          dividerColor:
                              const Color.fromARGB(255, 184, 183, 183),
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
                          borderColor: const [
                            Color.fromARGB(255, 184, 183, 183)
                          ],
                          borderWidth: 0.45,
                          activeBorders: [
                            Border.all(
                              color: ThemeColors.primary,
                              width: 1,
                            )
                          ],
                          dividerColor:
                              const Color.fromARGB(255, 184, 183, 183),
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
                          onPressed: () async {
                            String inviteCode = '';

                            String _youthAge = youthAge ?? '5';
                            String _parentsAge = parentsAge ?? '6';
                            String _emd = emd ?? '0';
                            String _sex = sex ?? '2';

                            // print(user_id);
                            // print(user_name);
                            // print(user_email);
                            // print(userRole);
                            // print(userTypeCode);

                            // print(youthAge);
                            // print(parentsAge);
                            // print(youthAge);
                            // print(emd);
                            // print(sex);

                            userBloc.add(OnRegisterKakaoUserEvent(
                                user_id,
                                user_name,
                                user_email,
                                userRole, // user_role - 사용자
                                userTypeCode.toString(), // user_type
                                _youthAge, // youthAge_code
                                _parentsAge, // parentsAge_code
                                _emd, //emd_class_code
                                _sex // sex_class_code
                                ));
                          }),
                    ],
                  ))),
        ));
  }
}
