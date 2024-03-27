import 'package:flutter/material.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/ui/screens/register/terms_detail_page.dart';
import 'package:teentalktalk/ui/screens/register/user_type_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

// kth 수정 : 밑에 수정 전 코드 주석처리 해놓음

class termsAgreePage extends StatefulWidget {
  const termsAgreePage({Key? key, required this.isKakaoLogin})
      : super(key: key);
  final bool isKakaoLogin;

  @override
  State<termsAgreePage> createState() => _termsAgreePageState();
}

class _termsAgreePageState extends State<termsAgreePage> {
  final allChecked = CheckBoxModal(title: '약관 전체 동의', required: '');
  final checkboxList = [
    CheckBoxModal(title: '회원가입 약관 동의', required: '(필수)', code: 0),
    CheckBoxModal(title: '개인정보 처리 방침 동의', required: '(필수)', code: 1),
    // CheckBoxModal(title: '마케팅 정보 수신 동의'),
  ];
  bool completeAgree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: const Text("약관 동의"),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: ThemeColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
          padding:
              // const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
              const EdgeInsets.all(30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const TextCustom(
              text: '약관동의',
              letterSpacing: 2.0,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
            const SizedBox(
              height: 50.0,
            ),
            ListTile(
              onTap: () => onAllClicked(allChecked),
              leading: Checkbox(
                value: allChecked.value,
                // checkColor: ThemeColors.basic,
                activeColor: ThemeColors.primary,
                onChanged: (value) {
                  onAllClicked(allChecked);
                },
              ),
              title: TextCustom(
                  text: allChecked.title,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...checkboxList
                .map((item) => ListTile(
                      onTap: () => onItemClicked(item),
                      leading: Checkbox(
                        checkColor: Colors.white,
                        activeColor: ThemeColors.primary,
                        value: item.value,
                        onChanged: (value) {
                          onItemClicked(item);
                        },
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextCustom(
                              text: item.title,
                              fontSize: 18,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextCustom(
                              text: item.required,
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: ThemeColors.basic,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => termsDetailPage(
                                        termsCode: item.code,
                                      ),
                                    ));
                              }),
                        ],
                      ),
                    ))
                .toList(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BtnNaru(
                  text: '다음',
                  width: 350,
                  height: 50,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  colorText: Colors.white,
                  // backgroundColor:
                  //     completeAgree ? ThemeColors.primary : Colors.grey,
                  onPressed: () {
                    print('약관 전체 동의');
                    // print(completeAgree);
                    if (completeAgree == true) {
                      // 다음 페이지
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userTypePage(
                              isKakaoLogin: widget.isKakaoLogin,
                            ),
                          ));
                    } else {
                      modalWarning(context, '약관에 동의해주세요');
                    }
                  },
                ),
              ),
            ),
          ])),
    );
  }

  onAllClicked(CheckBoxModal checkBoxItem) {
    final newValue = !checkBoxItem.value;
    setState(() {
      checkBoxItem.value = newValue;
      for (var element in checkboxList) {
        element.value = newValue;
        // print('onAllClicked');
        // print(element.value);
        completeAgree = element.value;
      }
    });
  }

  onItemClicked(CheckBoxModal checkBoxItem) {
    final newValue = !checkBoxItem.value;
    setState(() {
      checkBoxItem.value = newValue;

      if (!newValue) {
        // This is List checkbox not checked full all => So not need checked
        allChecked.value = false;
      } else {
        // This is List checkbox checked full => So need checked allChecked
        final allListChecked = checkboxList.every((element) => element.value);
        allChecked.value = allListChecked;
        // print('onItemClicked');
        // print(allChecked.value); // true
        completeAgree = allChecked.value;
      }
    });
  }
}

class CheckBoxModal {
  String title;
  String required;
  bool value;
  int code;

  CheckBoxModal(
      {required this.title,
      required this.required,
      this.value = false,
      this.code = -1});
}
