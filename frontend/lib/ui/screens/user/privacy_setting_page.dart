import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/ui/screens/user/email_edit_page.dart';
import 'package:teentalktalk/ui/screens/user/extra_info_edit_page.dart';
import 'package:teentalktalk/ui/screens/user/pw_edit_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class PrivacySettingPage extends StatefulWidget {
  const PrivacySettingPage({Key? key}) : super(key: key);

  @override
  State<PrivacySettingPage> createState() => _PrivacySettingPageState();
}

class _PrivacySettingPageState extends State<PrivacySettingPage> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {},
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const TextCustom(
                text: '개인 정보 설정',
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
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                        //사용자 이름
                        Container(
                          alignment: Alignment.center,
                          // padding: const EdgeInsets.all(20),
                          color: ThemeColors.third,
                          height: 200,
                          child: Center(
                              child: Container(child: const _UserProfile())),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // [기본 정보]
                                TextCustom(
                                  text: '기본 정보',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                _UserInfo(),

                                // [추가 정보]
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: const [
                                    TextCustom(
                                      text: '추가 정보',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    // 추가 정보 변경 버튼
                                    _UserInfoEditButton(
                                      editCode: 2,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                _UserExtraInfo(),
                              ]),
                        )
                      ]))
                ],
              ),
            ),
            bottomNavigationBar: const BottomNavigation(index: 5)));
  }
}

// 사용자 프로필

class _UserProfile extends StatefulWidget {
  const _UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<_UserProfile> {
  // const _UserProfile({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return TextCustom(
      text: userBloc.state.user!.user_name,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }
}

class _UserInfo extends StatefulWidget {
  const _UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<_UserInfo> {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    // print(userBloc.state.user!.userpw);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 이름
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 제목
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextCustom(
                  text: '이름',
                  fontSize: 15,
                  color: ThemeColors.basic,
                ),
                SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: '아이디',
                  fontSize: 15,
                  color: ThemeColors.basic,
                ),
                SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: '이메일 주소',
                  fontSize: 15,
                  color: ThemeColors.basic,
                ),
                SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: '비밀번호',
                  fontSize: 15,
                  color: ThemeColors.basic,
                ),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            // 값
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextCustom(
                  text: userBloc.state.user!.user_name,
                  fontSize: 15,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: userBloc.state.user!.userid,
                  fontSize: 15,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      text: userBloc.state.user!.user_email,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // 이메일 변경 버튼
                    const _UserInfoEditButton(
                      editCode: 0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // 비밀번호 변경 버튼
                const _UserInfoEditButton(
                  editCode: 1,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _UserExtraInfo extends StatefulWidget {
  const _UserExtraInfo({Key? key}) : super(key: key);

  @override
  _UserExtraInfoState createState() => _UserExtraInfoState();
}

class _UserExtraInfoState extends State<_UserExtraInfo> {
  // const _UserExtraInfo({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    late String ageCodeName = '';
    final String userTypeCode = userBloc.state.user!.user_type;

    if (userTypeCode == '0' || userTypeCode == '1') {
      ageCodeName = "youthAge_code";
    } else if (userTypeCode == '2') {
      ageCodeName = "parentsAge_code";
    }

    //사용자 유형
    final String userType =
        getMobileCodeService.getCodeDetailName("user_type", userTypeCode);
    //사용자 나이
    final String userAge = getMobileCodeService.getCodeDetailName(
        ageCodeName, userBloc.state.user!.youthAge_code);
    //사용자 성별
    final String userSex = getMobileCodeService.getCodeDetailName(
        "sex_class_code", userBloc.state.user!.sex_class_code);
    //사용자 거주지
    final String userEmd = getMobileCodeService.getCodeDetailName(
        "emd_class_code", userBloc.state.user!.emd_class_code);

    // return BlocBuilder<UserBloc, UserState>(builder: (_, state) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 이름
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 사용자 유형
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextCustom(
                  text: '사용자 유형',
                  fontSize: 15,
                  color: ThemeColors.basic,
                ),
                SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: '나이',
                  fontSize: 15,
                  color: ThemeColors.basic,
                ),
                SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: '성별',
                  fontSize: 15,
                  color: ThemeColors.basic,
                ),
                SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: '거주지',
                  fontSize: 15,
                  color: ThemeColors.basic,
                ),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            // 값
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  text: userType,
                  fontSize: 15,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: userAge,
                  fontSize: 15,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: userSex,
                  fontSize: 15,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextCustom(
                  text: userEmd,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
  // );
}

class _UserInfoEditButton extends StatefulWidget {
  final int editCode;

  const _UserInfoEditButton({Key? key, required this.editCode})
      : super(key: key);

  @override
  _UserInfoEditButtonState createState() => _UserInfoEditButtonState();
}

class _UserInfoEditButtonState extends State<_UserInfoEditButton> {
  // const _UserInfoEditButton({
  //   Key? key,
  //   required this.editCode,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editCode = widget.editCode;

    return InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(245, 245, 245, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const TextCustom(
          text: '변경',
          color: ThemeColors.primary,
          fontSize: 15,
        ),
      ),
      onTap: () {
        if (editCode == 0) {
          // 이메일 변경
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditEmailPage()),
          );
        } else if (editCode == 1) {
          // 비밀번호 변경
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditPasswordPage()),
          );
        } else if (editCode == 2) {
          // 추가 정보 변경
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditExtraInfoPage()),
          );
        }
      },
    );
  }
}
