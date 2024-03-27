import 'package:flutter/material.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // @override
  // void initState() {
  //   // 알림 설정 초기화
  //   FlutterLocalNotification.init();
  //   // 3초 뒤에 알림 권한 요청
  //   Future.delayed(const Duration(seconds: 3),
  //       FlutterLocalNotification.requestNotificationPermission());
  //   super.initState();
  // }

  // Widget _buildNotificationListTile() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(
  //           color: Colors.grey.withOpacity(0.5),
  //           width: 1,
  //         ),
  //       ),
  //     ),
  //     child: ListTile(
  //       contentPadding: const EdgeInsets.all(5),
  //       title: const TextCustom(
  //         text: '알림 제목',
  //         fontWeight: FontWeight.bold,
  //         maxLines: 1,
  //         overflow: TextOverflow.ellipsis,
  //       ),
  //       subtitle: const TextCustom(
  //         text: '2023.05.12', // 현재 날짜를 표시
  //         fontSize: 12,
  //         color: ThemeColors.basic,
  //       ),
  //       onTap: () {},
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // print(userTypeCode);
    // final userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const TextCustom(
            text: '알림함',
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
        body: SafeArea(child: Container()

            // Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            //     child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           TextButton(
            //             onPressed: () =>
            //                 FlutterLocalNotification.showNotification(),
            //             child: const Text("알림 보내기"),
            //           ),
            //           _buildNotificationListTile()
            //         ])),

            ));
  }
}
