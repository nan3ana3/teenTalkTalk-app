import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/ui/screens/policy/policy_list_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class PolicySearchFilterPage extends StatefulWidget {
  const PolicySearchFilterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PolicySearchFilterPage> createState() => _PolicySearchFilterState();
}

class _PolicySearchFilterState extends State<PolicySearchFilterPage> {
  late CodeDetailData selectedCode;
  final SelectedCodes selectedCodeList = SelectedCodes();

  void setSelectedCodeData(CodeDetailData data) {
    setState(() {
      selectedCode = data;
    });

    switch (data.codeName) {
      case 'policy_institution_code':
        if (selectedCodeList.policyInstitution != null &&
            selectedCodeList.policyInstitution!.contains(data)) {
          selectedCodeList.policyInstitution!.remove(data);
        } else {
          selectedCodeList.policyInstitution = [data];
        }
        break;
      case 'policy_target_code':
        if (selectedCodeList.policyTarget != null &&
            selectedCodeList.policyTarget!.contains(data)) {
          selectedCodeList.policyTarget!.remove(data);
        } else {
          selectedCodeList.policyTarget = [data];
        }
        break;
      case 'policy_field_code':
        if (selectedCodeList.policyField != null &&
            selectedCodeList.policyField!.contains(data)) {
          selectedCodeList.policyField!.remove(data);
        } else {
          selectedCodeList.policyField = [data];
        }
        break;
      case 'policy_character_code':
        if (selectedCodeList.policyCharacter != null &&
            selectedCodeList.policyCharacter!.contains(data)) {
          selectedCodeList.policyCharacter!.remove(data);
        } else {
          selectedCodeList.policyCharacter = [data];
        }
        break;
      // case 'emd_class_code':
      //   if (selectedCodeList.policyArea != null &&
      //       selectedCodeList.policyArea!.contains(data)) {
      //     selectedCodeList.policyArea!.remove(data);
      //   } else {
      //     selectedCodeList.policyArea = [data];
      //   }
      //   break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // -----
    // print('SelectedCodes=======');

    // if (selectedCodeList.policyInstitution != null) {
    //   selectedCodeList.policyInstitution!.forEach((element) {
    //     print('policyInstitution : ${element.detailName}');
    //   });
    // } else {
    //   print('policyInstitution : null');
    // }
    // if (selectedCodeList.policyTarget != null) {
    //   selectedCodeList.policyTarget!.forEach((element) {
    //     print('policyTarget : ${element.detailName}');
    //   });
    // } else {
    //   print('policyTarget : null');
    // }
    // if (selectedCodeList.policyField != null) {
    //   selectedCodeList.policyField!.forEach((element) {
    //     print('policyField : ${element.detailName}');
    //   });
    // } else {
    //   print('policyField : null');
    // }
    // if (selectedCodeList.policyCharacter != null) {
    //   selectedCodeList.policyCharacter!.forEach((element) {
    //     print('policyCharacter : ${element.detailName}');
    //   });
    // } else {
    //   print('policyCharacter : null');
    // }
    // if (selectedCodeList.policyArea != null) {
    //   selectedCodeList.policyArea!.forEach((element) {
    //     print('policyArea : ${element.detailName}');
    //   });
    // } else {
    //   print('policyArea : null');
    // }

    //-----

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const TextCustom(
            text: '상세 검색 조건',
            color: ThemeColors.basic,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchConditionList(
                    title: '운영 기관',
                    codeName: 'policy_institution_code',
                    setSelectedCodeData: (data) {
                      setSelectedCodeData(data);
                    }),
                const SizedBox(
                  height: 20,
                ),
                SearchConditionList(
                    title: '적용 대상',
                    codeName: 'policy_target_code',
                    setSelectedCodeData: (data) {
                      setSelectedCodeData(data);
                    }),
                const SizedBox(
                  height: 20,
                ),
                SearchConditionList(
                    title: '정책 분야',
                    codeName: 'policy_field_code',
                    setSelectedCodeData: (data) {
                      setSelectedCodeData(data);
                    }),
                const SizedBox(
                  height: 20,
                ),
                SearchConditionList(
                    title: '정책 성격',
                    codeName: 'policy_character_code',
                    setSelectedCodeData: (data) {
                      setSelectedCodeData(data);
                    }),
                const SizedBox(
                  height: 20,
                ),
                // SearchConditionList(
                //     title: '지역',
                //     codeName: 'emd_class_code',
                //     setSelectedCodeData: (data) {
                //       setSelectedCodeData(data);
                //     }),
                // const SizedBox(
                //   height: 20,
                // ),
                Center(
                    child: BtnNaru(
                  text: '검색하기',
                  onPressed: () {
                    Navigator.pop(context, {});

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PolicyListPage(
                                // codeDetail: selectedCode.code,
                                // codeName: selectedCode.codeName,
                                //selectedCodes : selectedCodes,
                                selectedCodes: selectedCodeList)),
                        (_) => false);
                  },
                  width: size.width - 30,
                  colorText: Colors.black,
                  backgroundColor: ThemeColors.secondary,
                  border: 10,
                ))
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class SearchConditionList extends StatefulWidget {
  final String title;
  final String codeName;
  final void Function(CodeDetailData) setSelectedCodeData;

  const SearchConditionList({
    Key? key,
    required this.title,
    required this.codeName,
    required this.setSelectedCodeData, //콜백 함수 전달
  }) : super(key: key);

  @override
  State<SearchConditionList> createState() => _SearchConditionListState();
}

class _SearchConditionListState extends State<SearchConditionList> {
  List<CodeDetailData> codeDetailDataList = [];
  CodeDetailData? selectedCodeData;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    codeDetailDataList =
        getMobileCodeService.getCodeDetailList(widget.codeName);
  }

  void _onSelected(CodeDetailData data) {
    setState(() {
      //   if (_selectedCode != null && _selectedCode != data) {
      //     _selectedCode!.selected = false;
      //   }
      //   data.selected = !data.selected;
      //   _selectedCode = data;
    });

    widget.setSelectedCodeData(data);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String title = widget.title;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 10),
          child: Text(
            title,
            style: const TextStyle(
                color: ThemeColors.basic,
                fontFamily: 'NanumSquareRound',
                fontWeight: FontWeight.w600,
                fontSize: 20),
          )),
      Center(
          child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ...List.generate(
            codeDetailDataList.length,
            (index) {
              final codeDetailData = codeDetailDataList[index];
              return InkWell(
                onTap: () {
                  final selectedValue = codeDetailDataList[index];
                  setState(() {
                    _onSelected(selectedValue);
                    if (selectedIndex != index) {
                      if (selectedIndex != -1) {
                        codeDetailDataList[selectedIndex].selected = false;
                      }
                      selectedValue.selected = true;
                      selectedIndex = index;
                    } else {
                      selectedValue.selected = false;
                      selectedIndex = -1;
                    }
                  });
                },
                child: Container(
                  width: (size.width / 2) - 30,
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: codeDetailData.selected == true
                        ? ThemeColors.secondary
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextCustom(
                      text: codeDetailData.detailName,
                      color: codeDetailData.selected == true
                          ? Colors.black
                          : ThemeColors.basic,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ))
    ]);
  }
}
