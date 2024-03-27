// import 'package:flutter/material.dart';
// import 'package:teentalktalk/ui/helpers/helpers.dart';
// import 'package:teentalktalk/ui/screens/login/login_page.dart';
// import 'package:teentalktalk/ui/screens/register/terms_agree.dart';
// import 'package:teentalktalk/ui/screens/register/user_type.dart';
// import 'package:teentalktalk/ui/themes/theme_colors.dart';
// import 'package:teentalktalk/ui/widgets/widgets.dart';

// import '../../helpers/animation_route.dart';

// class Todo {
//   final String title;
//   final String description;

//   Todo(this.title, this.description);
// }

// class StartRegisterPage extends StatelessWidget {
//   const StartRegisterPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('회원가입',
//               style: TextStyle(color: Colors.black, fontSize: 20)),
//           backgroundColor: ThemeColors.primary,
//           centerTitle: false,
//           elevation: 0.0,
//         ),
//         body: SafeArea(
//             child: Column(children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             height: 50,
//             width: size.width,
//             child: Row(
//                 // children: [
//                 //   Image.asset('assets/img/yeongam_logo.jpeg', height: 30),
//                 // ],
//                 ),
//           ),

//           // const TextCustom(
//           //   text: '앱 이름',
//           //   letterSpacing: 2.0,
//           //   color: ThemeColors.primary,
//           //   fontWeight: FontWeight.w100,
//           //   fontSize: 30,
//           //   textAlign: TextAlign.left,
//           // ),
//           const TextCustom(
//             text: '회원가입',
//             letterSpacing: 2.0,
//             color: Colors.black,
//             fontWeight: FontWeight.w900,
//             fontSize: 30,
//           ),

//           const SizedBox(
//             height: 10.0,
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: TextCustom(
//               text: ('회원가입 방식을 선택해주세요'),
//               // textAlign : TextAlign.center,
//               maxLines: 2,
//               fontSize: 17,
//             ),
//           ),
//           const SizedBox(height: 50.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: SizedBox(
//               height: 50,
//               width: size.width,
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                     backgroundColor: ThemeColors.primary,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0))),
//                 child: const TextCustom(
//                     text: '개인 회원가입', color: Colors.black, fontSize: 20),
//                 onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const termsAgreePage(),
//                     )),
//               ),
//             ),
//           ),

//           const SizedBox(height: 30.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: SizedBox(
//               height: 50,
//               width: size.width,
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                     backgroundColor: const Color.fromRGBO(247, 225, 17, 1),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0))),
//                 child: const TextCustom(
//                     text: '카카오톡 회원가입', color: Colors.black, fontSize: 20),
//                 onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const termsAgreePage(),
//                     )),
//               ),
//             ),
//           ),

//           const SizedBox(height: 20.0),
//         ])));
//   }
// }
