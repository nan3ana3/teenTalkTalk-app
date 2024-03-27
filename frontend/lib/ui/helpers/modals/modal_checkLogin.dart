import 'package:flutter/material.dart';
import 'package:teentalktalk/ui/screens/login/login_page.dart';
import 'package:teentalktalk/ui/screens/login/no_login_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalCheckLogin(BuildContext context) {
  final size = MediaQuery.of(context).size;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 3.7,
            width: double.maxFinite,
            clipBehavior: Clip.none,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Material(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    height: 25,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextCustom(
                    text: '로그인하고 \n나에게 필요한 정책을 관리해보세요',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                  const SizedBox(height: 5),
                  const TextCustom(
                    text: '다양한 이벤트도 참여할 수 있어요!',
                    fontSize: 12,
                    color: ThemeColors.basic,
                  ),
                  const SizedBox(height: 16),
                  Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: ThemeColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: BtnNaru(
                        width: size.width,
                        text: '로그인하러가기',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const NoLoginPage()),
                          // );
                        },
                      ))
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation1,
          curve: Curves.easeInOut,
        );
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(curvedAnimation),
          child: child,
        );
        // return SlideTransition(
        //   position: Tween(
        //     begin: const Offset(0, 1),
        //     end: const Offset(0, 0),
        //   ).animate(animation1),
        //   child: child,
        // );
      },
    );
  });
}

  



// Widget _buildDialogContent(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 4,
//       width: double.maxFinite,
//       clipBehavior: Clip.none,
//       padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: Material(
//         color: Colors.white,
//         child: Column(
//           children: [
//             _buildCancelIcon(context),
//             const SizedBox(height: 10),
//             _buildContinueText(),
//             const SizedBox(height: 5),
//             _buildExtraText(),
//             const SizedBox(height: 16),
//             _buildContinueButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCancelIcon(BuildContext context) {
//     return Container(
//       alignment: Alignment.topRight,
//       height: 25,
//       child: IconButton(
//         icon: const Icon(Icons.close),
//         iconSize: 20,
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }

//   Widget _buildContinueText() {
//     return const TextCustom(
//       text: '로그인하고 \n나에게 필요한 정책을 관리해보세요',
//       textAlign: TextAlign.center,
//       maxLines: 2,
//       fontSize: 20,
//       fontWeight: FontWeight.w600,
//       height: 1.5,
//     );
//   }

//   Widget _buildExtraText() {
//     return const TextCustom(
//       text: '다양한 이벤트도 참여할 수 있어요!',
//       fontSize: 12,
//       color: ThemeColors.basic,
//     );
//   }

//   Widget _buildContinueButton(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 20,
//       width: double.maxFinite,
//       decoration: const BoxDecoration(
//         color: ThemeColors.primary,
//         borderRadius: BorderRadius.all(Radius.circular(30)),
//       ),
//       child: RawMaterialButton(
//         onPressed: () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const LoginPage()),
//           );
//         },
//         child: const Center(
//           child: TextCustom(
//             text: '로그인하러가기',
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w800,
//             letterSpacing: 1.2,
//           ),
//         ),
//       ),
//     );
//   }