import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class EditEmailPage extends StatefulWidget {
  const EditEmailPage({Key? key}) : super(key: key);

  @override
  State<EditEmailPage> createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  late TextEditingController emailController;
  final _keyForm = GlobalKey<FormState>();
  String? initialEmail;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: initialEmail);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userBloc = BlocProvider.of<UserBloc>(context);
    initialEmail = userBloc.state.user?.user_email;
    emailController.text = initialEmail ?? '';
  }

  @override
  void dispose() {
    // emailController.clear();
    // emailController.dispose();
    super.dispose();
  }

  void clear() {
    emailController.clear();
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
            Navigator.pop(context);
            errorMessageSnack(context, state.error);
          }
          if (state is SuccessUserState) {
            modalSuccess(context, '저장되었습니다!', onPressed: () {
              clear();
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pushReplacement(
              //   context,
              //   routeFade(page: const PrivacySettingPage()),
              //   result: emailController.text.trim(),
              // );
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
                      horizontal: 30.0, vertical: 40.0),
                  child: Form(
                    key: _keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextCustom(
                          text: '이메일 주소 변경',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const TextCustom(
                          text: '이메일 주소를 입력해주세요',
                          color: ThemeColors.basic,
                          fontSize: 15,
                        ),
                        TextFieldNaru(
                          controller: emailController,
                          validator: validatedEmail,
                          fontSize: 20,
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
                                // userService.changeEmail(
                                //     initialEmail!, emailController.text.trim());
                                if (_keyForm.currentState!.validate()) {
                                  userBloc.add(OnChangeEmailEvent(
                                      initialEmail!.trim(),
                                      emailController.text.trim()));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))),
        ));
  }
}
