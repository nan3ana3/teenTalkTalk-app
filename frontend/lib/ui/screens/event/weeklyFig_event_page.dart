import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teentalktalk/ui/screens/event/fig_market_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class WeeklyFigEventPage extends StatefulWidget {
  const WeeklyFigEventPage({Key? key}) : super(key: key);

  @override
  State<WeeklyFigEventPage> createState() => _WeeklyFigEventPageState();
}

class _WeeklyFigEventPageState extends State<WeeklyFigEventPage> {
  @override
  Widget build(BuildContext context) {
    int week = 1;
    List<bool> getWeekCheckList = [false, false, false, false];
    List<String> challengeList = [
      "웰컴 청소년 톡talk",
      "톡talk 알림 허용하기",
      "친구에게 정책 공유하기",
      "관심있는 정책 스크랩하기"
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromRGBO(251, 238, 231, 1),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromRGBO(251, 238, 231, 1),
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ThemeColors.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                Text(
                  "주간 무화과 챌린지",
                  style: TextStyle(
                      fontSize: 35.sp,
                      color: ThemeColors.primary,
                      fontFamily: 'CookieRun'),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 168.h),
                      child: week == 1
                          ? SvgPicture.asset(
                              'images/event_icon/weekly_event/1_week.svg',
                              width: 300.w)
                          : week == 2
                              ? SvgPicture.asset(
                                  'images/event_icon/weekly_event/2_week.svg',
                                  width: 300.w)
                              : week == 3
                                  ? SvgPicture.asset(
                                      'images/event_icon/weekly_event/3_week.svg',
                                      width: 300.w)
                                  : week == 4
                                      ? SvgPicture.asset(
                                          'images/event_icon/weekly_event/4_week.svg',
                                          width: 300.w)
                                      : Container(),
                    ),
                    Image.asset(
                        'images/event_icon/weekly_event/week_mainText.png',
                        width: 290.w),
                  ],
                ),
                SizedBox(height: 40.h),
                InkWell(
                  onTap: () {},
                  child: challengeWidget(
                      text: week >= 1 ? challengeList[0] : "어떤 미션이 기다리고 있을까요?",
                      imagePath: 'images/event_icon/oneIcon.svg',
                      isEvent: week == 1 ? true : false,
                      isCheck: getWeekCheckList[0]),
                ),
                SizedBox(height: 27.h),
                InkWell(
                  onTap: () {},
                  child: challengeWidget(
                      text: week >= 2 ? challengeList[1] : "어떤 미션이 기다리고 있을까요?",
                      imagePath: 'images/event_icon/twoIcon.svg',
                      isEvent: week == 2 ? true : false,
                      isCheck: getWeekCheckList[1]),
                ),
                SizedBox(height: 27.h),
                InkWell(
                  onTap: () {},
                  child: challengeWidget(
                      text: week >= 3 ? challengeList[2] : "어떤 미션이 기다리고 있을까요?",
                      imagePath: 'images/event_icon/threeIcon.svg',
                      isEvent: week == 3 ? true : false,
                      isCheck: getWeekCheckList[2]),
                ),
                SizedBox(height: 27.h),
                InkWell(
                  onTap: () {},
                  child: challengeWidget(
                      text: week >= 4 ? challengeList[3] : "어떤 미션이 기다리고 있을까요?",
                      imagePath: 'images/event_icon/fourIcon.svg',
                      isEvent: week == 4 ? true : false,
                      isCheck: getWeekCheckList[3]),
                ),
                SizedBox(height: 27.h),
                Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 17.w, right: 30.h),
                        child: Image.asset(
                            'images/event_icon/weekly_event/week_subText.png')),
                    Container(
                      margin: EdgeInsets.only(left: 143.w, top: 61.5.h),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FigMarketPage(),
                                ));
                          },
                          child: Container(
                            height: 21.h,
                            width: 131.h,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          )),
                    )
                  ],
                ),
              ],
            )),
          ),
        ));
  }

  Widget challengeWidget({
    required String text,
    required String imagePath,
    required bool isEvent,
    bool isCheck = false,
  }) {
    if (isCheck) {
      return Stack(
        children: [
          Container(
            child: Container(
              width: 300.w,
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(color: ThemeColors.primary, width: 2.w),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: SvgPicture.asset(imagePath, width: 30.w),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    TextCustom(
                        text: text, color: Colors.black, fontSize: 15.sp),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 300.w,
            height: 50.h,
            decoration: BoxDecoration(
              border: Border.all(color: ThemeColors.primary, width: 2.w),
              color: const Color.fromRGBO(245, 117, 33, 0.5),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: TextCustom(
                      text: "완료", color: Colors.white, fontSize: 20.sp),
                )),
          )
        ],
      );
    } else {
      return Container(
        width: 300.w,
        height: 50.h,
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColors.primary, width: 2.w),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: SvgPicture.asset(imagePath, width: 30.w),
              ),
              SizedBox(
                width: 8.w,
              ),
              isEvent
                  ? Text(text,
                      style: TextStyle(
                          fontFamily: "cookieRun",
                          color: ThemeColors.primary,
                          fontSize: 20.sp))
                  : TextCustom(
                      text: text, color: Colors.black, fontSize: 15.sp),
            ],
          ),
        ),
      );
    }
  }
}
