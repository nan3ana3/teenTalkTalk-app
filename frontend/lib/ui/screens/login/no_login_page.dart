// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// // import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
// import 'package:teentalktalk/domain/blocs/blocs.dart';
// import 'package:teentalktalk/domain/services/auth_services.dart';
// import 'package:teentalktalk/domain/services/event_services.dart';
// import 'package:teentalktalk/ui/helpers/helpers.dart';
// import 'package:teentalktalk/ui/helpers/kakao_sdk_login.dart';
// import 'package:teentalktalk/ui/helpers/modals/modal_basic.dart';
// import 'package:teentalktalk/ui/helpers/modals/modal_preparing.dart';
// import 'package:teentalktalk/ui/screens/home/home_page.dart';
// import 'package:teentalktalk/ui/screens/login/find_pw_page.dart';
// import 'package:teentalktalk/ui/screens/login/find_id_page.dart';
// import 'package:teentalktalk/ui/screens/register/terms_agree_page.dart';
// import 'package:teentalktalk/ui/screens/register/user_type_page.dart';
// import 'package:teentalktalk/ui/themes/theme_colors.dart';
// import 'package:teentalktalk/ui/widgets/widgets.dart';

// class NoLoginPage extends StatefulWidget {
//   const NoLoginPage({Key? key}) : super(key: key);

//   @override
//   State<NoLoginPage> createState() => _NoLoginPageState();
// }

// class _NoLoginPageState extends State<NoLoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final authBloc = BlocProvider.of<AuthBloc>(context);
//     final userBloc = BlocProvider.of<UserBloc>(context);

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                 color: ThemeColors.primary),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//       ),
//       body: const SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
//           child: SingleChildScrollView(
//             child: TextCustom(
//               text: '준비중입니다',
//               maxLines: 2,
//               height: 1.5,
//               fontWeight: FontWeight.w400,
//               fontSize: 24,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
