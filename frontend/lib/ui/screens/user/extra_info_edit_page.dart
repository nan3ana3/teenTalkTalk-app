import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditExtraInfoPage extends StatefulWidget {
  const EditExtraInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditExtraInfoPage> createState() => _EditExtraInfoPageState();
}

class _EditExtraInfoPageState extends State<EditExtraInfoPage> {
  late String initialEmd;

  late String initialYouthAge;
  late String initialParentsAge;
  late String initialSex;
  late String userTypeCode;

  late String youthAge = '';
  late String parentsAge = '';
  late String sex = '';
  late String emd = '';
  List<CodeDetailData> youthAgeList = [];
  List<CodeDetailData> parentsAgeList = [];
  List<CodeDetailData> sexList = [];
  List<CodeDetailData> emdList = [];

  @override
  void initState() {
    super.initState();
    youthAgeList = getMobileCodeService.getCodeDetailList('youthAge_code');
    parentsAgeList = getMobileCodeService.getCodeDetailList('parentsAge_code');
    sexList = getMobileCodeService.getCodeDetailList('sex_class_code');
    emdList = getMobileCodeService.getCodeDetailList('emd_class_code');
    userTypeCode = BlocProvider.of<UserBloc>(context).state.user!.user_type;
    initialEmd = BlocProvider.of<UserBloc>(context).state.user!.emd_class_code;
    initialYouthAge =
        BlocProvider.of<UserBloc>(context).state.user!.youthAge_code;
    initialParentsAge =
        BlocProvider.of<UserBloc>(context).state.user!.parentsAge_code;
    initialSex = BlocProvider.of<UserBloc>(context).state.user!.sex_class_code;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print(userTypeCode);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // print(state);

          if (state is LoadingEditUserState) {
            modalLoading(context, '확인 중...');
          }
          if (state is FailureUserState) {
            Navigator.pop(context);
            errorMessageSnack(context, state.error);
          }
          if (state is SuccessUserState) {
            modalSuccess(context, '저장되었습니다!', onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            // title: const TextCustom(
            //   text: '개인 정보 설정',
            //   color: Colors.black,
            //   fontSize: 20,
            //   fontWeight: FontWeight.w600,
            // ),
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
                        text: '추가 정보 변경',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 30,
                      ),

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
                                    orElse: () =>
                                        emdList[int.parse(initialEmd)])
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
                                        orElse: () => emdList[1])
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
                      if (userTypeCode == '0' || userTypeCode == '1') ...[
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
                          initialLabelIndex: int.parse(initialYouthAge),
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
                            // print('school - switched to : $index');
                            youthAge = youthAgeList[index!].code;
                            parentsAge = '6'; // 선택안함
                          },
                        ),
                      ] else if (userTypeCode == '2') ...[
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
                          initialLabelIndex: int.parse(initialParentsAge),
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
                            // print('age - switched to : $index');
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
                        initialLabelIndex: int.parse(initialSex),
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
                          // print('sex - switched to : $index');
                          sex = sexList[index!].code;
                        },
                      ),

                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: BtnNaru(
                            text: '저장',
                            width: size.width,
                            fontWeight: FontWeight.bold,
                            height: 50,
                            onPressed: () {
                              final emdToSend = emd.isEmpty ? initialEmd : emd;
                              final youthAgeToSend =
                                  youthAge.isEmpty ? initialYouthAge : youthAge;
                              final parentsAgeToSend = parentsAge.isEmpty
                                  ? initialParentsAge
                                  : parentsAge;
                              final sexToSend = sex.isEmpty ? initialSex : sex;

                              userBloc.add(OnChangeExtraInfoEvent(emdToSend,
                                  youthAgeToSend, parentsAgeToSend, sexToSend));
                            },
                          ),
                        ),
                      ),
                    ],
                  ))),
        ));
  }
}
