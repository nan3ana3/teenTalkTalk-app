import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({Key? key}) : super(key: key);

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController newPasswordAgainController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    newPasswordAgainController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordAgainController.dispose();
    super.dispose();
  }

  void clear() {
    currentPasswordController.clear();
    newPasswordAgainController.clear();
    newPasswordAgainController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // print(state);

          if (state is LoadingEditUserState) {
            modalLoading(context, '확인 중...');
          }
          if (state is FailureUserState) {
            // Navigator.pop(context);
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
              child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Form(
                        key: _keyForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextCustom(
                              text: '비밀번호 변경',
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const TextCustom(
                              text: '현재 비밀번호를 입력해주세요',
                              color: ThemeColors.basic,
                              fontSize: 15,
                            ),
                            TextFieldNaru(
                              controller: currentPasswordController,
                              validator: passwordValidator,
                              // hintText: '현재 비밀번호',
                              isPassword: true,
                              fontSize: 20,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const TextCustom(
                              text: '새 비밀번호를 입력해주세요',
                              color: ThemeColors.basic,
                              fontSize: 15,
                            ),
                            TextFieldNaru(
                              controller: newPasswordController,
                              validator: passwordValidator,
                              // hintText: '새 비밀번호',
                              isPassword: true,
                              fontSize: 20,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const TextCustom(
                              text: '새 비밀번호를 다시 입력해주세요',
                              color: ThemeColors.basic,
                              fontSize: 15,
                            ),
                            TextFieldNaru(
                              controller: newPasswordAgainController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '비밀번호 확인을 입력해주세요.';
                                }
                                return ConfirmPasswordValidator.validate(
                                  newPasswordController.text,
                                  value,
                                );
                              },
                              isPassword: true,
                              fontSize: 20,
                            ),
                          ],
                        ),
                      )))),
          bottomNavigationBar: BtnNaru(
            margin: EdgeInsets.all(20.h),
            text: '저장',
            width: size.width,
            fontWeight: FontWeight.bold,
            height: 50,
            onPressed: () {
              if (_keyForm.currentState!.validate()) {
                userBloc.add(OnChangePasswordEvent(
                    currentPasswordController.text.trim(),
                    newPasswordAgainController.text.trim()));
              }
            },
          ),
        ));
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
