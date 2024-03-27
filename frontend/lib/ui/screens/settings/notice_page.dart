import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/domain/models/response/response_notice.dart';
import 'package:teentalktalk/domain/services/notice_services.dart';
import 'package:teentalktalk/ui/screens/settings/notice_detail_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const TextCustom(
                text: '공지사항',
                color: ThemeColors.basic,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ThemeColors.primary,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SafeArea(
              child: Column(children: [
                Expanded(
                  child: Center(
                    child: FutureBuilder<List<Notice>>(
                      future: noticeService.getNoticeData(),
                      builder: (_, snapshot) {
                        if (snapshot.data != null && snapshot.data!.isEmpty) {
                          return _ListWithoutNotice();
                        }

                        return !snapshot.hasData
                            ? const _ShimerLoading()
                            : Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: false,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (_, i) => ListViewNotice(
                                        notices: snapshot.data![i],
                                      ),
                                    ),
                                  )
                                ],
                              );
                      },
                    ),
                  ),
                )
              ]),
            )));
  }
}

class ListViewNotice extends StatefulWidget {
  final Notice notices;

  const ListViewNotice({
    Key? key,
    required this.notices,
  }) : super(key: key);

  @override
  State<ListViewNotice> createState() => _ListViewNoticeState();
}

class _ListViewNoticeState extends State<ListViewNotice> {
  @override
  Widget build(BuildContext context) {
    final Notice notices = widget.notices;
    final String title = notices.title;
    final String register_date = notices.ins_date.substring(0, 10);

    return Container(
      // padding: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
        title: TextCustom(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
          maxLines: 2,
          height: 1.3,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: TextCustom(
          text: register_date, //'2023.05.12', // 현재 날짜를 표시
          fontSize: 12,
          color: ThemeColors.basic,
          height: 3,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailNoticePage(notices),
            ),
          );
        },
      ),
    );
  }
}

// 등록된 공지 없을 때
class _ListWithoutNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/aco4.png',
                height: size.height / 4,
              ),
              const SizedBox(
                height: 10,
              ),
              const TextCustom(text: '등록된 공지가 없어요', fontSize: 20),
            ],
          ),
        ));
  }
}

// 로딩
class _ShimerLoading extends StatelessWidget {
  const _ShimerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ShimmerNaru(),
        SizedBox(height: 10.0),
        ShimmerNaru(),
        SizedBox(height: 10.0),
        ShimmerNaru(),
      ],
    );
  }
}
