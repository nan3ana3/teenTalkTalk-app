// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:teentalktalk/domain/blocs/blocs.dart';
// import 'package:teentalktalk/ui/helpers/helpers.dart';
// import 'package:teentalktalk/ui/screens/login/login_page.dart';
// import 'package:teentalktalk/ui/themes/theme_colors.dart';
// import 'package:teentalktalk/ui/widgets/widgets.dart';

// class VerifyEmailPage extends StatelessWidget {
//   final String user_email;

//   const VerifyEmailPage({Key? key, required this.user_email}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final userBloc = BlocProvider.of<UserBloc>(context);
//     print('VerifyEmailPage!!');

//     return BlocListener<UserBloc, UserState>(
//       listener: (context, state) {
//         print('verifyEmail state');
//         if (state is LoadingUserState) {
//           modalLoading(context, '코드 확인 중...');
//         } else if (state is SuccessUserState) {
//           print('verify_eamil_page SuccessUserState');
//           // Navigator.pop(context);
//           modalSuccess(context, '환영합니다!',
//               onPressed: () => Navigator.pushAndRemoveUntil(
//                   context, routeSlide(page: const LoginPage()), (_) => false));
//         } else if (state is FailureUserState) {
//           print('verify_eamil_page FailureUserState');
//           Navigator.pop(context);
//           errorMessageSnack(context, state.error);
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                 color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(20.0),
//                     height: 300,
//                     width: size.width,
//                     decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(.1),
//                         borderRadius: BorderRadius.circular(8.0)),
//                     // child: SvgPicture.asset('assets/svg/undraw_opened_email.svg'),
//                   ),
//                   const SizedBox(height: 20.0),
//                   const TextCustom(
//                       text: '이메일을 확인해주세요.',
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500),
//                   const SizedBox(height: 20.0),
//                   TextCustom(
//                     text: '이메일 주소로 전송된 5자리 코드를 입력하세요. $user_email',
//                     maxLines: 3,
//                     fontSize: 16,
//                     color: Colors.grey,
//                   ),
//                   const SizedBox(height: 30.0),
//                   PinCodeTextField(
//                       appContext: context,
//                       length: 5,
//                       keyboardType: TextInputType.number,
//                       pinTheme: PinTheme(
//                           inactiveColor: ThemeColors.secondary,
//                           activeColor: ThemeColors.primary),
//                       onChanged: (value) {},
//                       onCompleted: (value) =>
//                           userBloc.add(OnVerifyEmailEvent(user_email, value)))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
