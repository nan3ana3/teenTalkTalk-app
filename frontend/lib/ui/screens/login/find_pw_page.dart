import 'package:flutter/material.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class FindPasswordPage extends StatefulWidget {
  const FindPasswordPage({Key? key}) : super(key: key);

  @override
  State<FindPasswordPage> createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController userIdController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    userIdController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.clear();
    emailController.dispose();
    userNameController.clear();
    userNameController.dispose();
    userIdController.clear();
    userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextCustom(
                  text: '비밀번호 찾기',
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: Colors.black,
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 70,
                  width: size.width,
                  // child: SvgPicture.asset('assets/svg/undraw_forgot_password.svg'),
                ),
                const TextCustom(
                  text: '이름을 입력해주세요.',
                  fontSize: 17,
                  letterSpacing: 1.0,
                  maxLines: 2,
                ),
                const SizedBox(height: 1.0),
                TextFieldNaru(
                  controller: userNameController,
                  hintText: '이름',
                ),
                const SizedBox(height: 40.0),
                const TextCustom(
                  text: '아이디를 입력해주세요.',
                  fontSize: 17,
                  letterSpacing: 1.0,
                  maxLines: 2,
                ),
                TextFieldNaru(
                  controller: userIdController,
                  hintText: '아이디',
                ),
                const SizedBox(height: 40.0),
                const TextCustom(
                  text: '이메일을 입력해주세요.',
                  fontSize: 17,
                  letterSpacing: 1.0,
                  maxLines: 2,
                ),
                TextFieldNaru(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: '이메일',
                ),
                const SizedBox(height: 70.0),
                BtnNaru(
                  text: '비밀번호 찾기',
                  colorText: Colors.white,
                  fontWeight: FontWeight.bold,
                  width: size.width,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
