import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/domain/blocs/auth/auth_bloc.dart';
import 'package:teentalktalk/domain/blocs/user/user_bloc.dart';
import 'package:teentalktalk/ui/helpers/animation_route.dart';
import 'package:teentalktalk/ui/screens/home/home_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalLogout(
  BuildContext context,
) {
  showDialog(
    useRootNavigator: true,
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: SizedBox(
        height: 200.h,
        width: 300.w,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '청소년 톡talk',
                  style: TextStyle(
                      color: ThemeColors.primary,
                      fontFamily: 'CookieRun',
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: ThemeColors.basic,
                  ),
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            SizedBox(height: 10.0.h),
            Container(
              padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
              child: const TextCustom(
                text: '로그아웃하시겠습니까?',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 100.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                        color: ThemeColors.primary,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const TextCustom(
                      text: '취소',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    final userBloc = BlocProvider.of<UserBloc>(context);
                    final authBloc = BlocProvider.of<AuthBloc>(context);
                    // Navigator.pop(context);
                    authBloc.add(OnLogOutEvent());
                    userBloc.add(OnLogOutUser());

                    Navigator.pushAndRemoveUntil(
                      context,
                      routeFade(page: const HomePage()),
                      (_) => false,
                    );
                  },
                  child: Container(
                    width: 100.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const TextCustom(
                      text: '로그아웃',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
