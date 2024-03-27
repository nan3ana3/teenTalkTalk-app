import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/domain/services/event_services.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_checkLogin.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_preparing.dart';
import 'package:teentalktalk/ui/screens/event/fig_market_page.dart';
import 'package:teentalktalk/ui/screens/event/weekly_fig_mission/01_week_page.dart';
import 'package:teentalktalk/ui/screens/event/weekly_fig_mission/00_week_page.dart';
import 'package:teentalktalk/ui/screens/event/weekly_fig_mission/03_week_page.dart';
import 'package:teentalktalk/ui/screens/event/weekly_fig_mission/02_week_page.dart';

import 'package:teentalktalk/ui/screens/user/my_fig_history_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';
import 'package:stroke_text/stroke_text.dart';

class NewWeeklyFigEventPage extends StatefulWidget {
  const NewWeeklyFigEventPage({Key? key}) : super(key: key);

  @override
  State<NewWeeklyFigEventPage> createState() => _NewWeeklyFigEventPageState();
}

class _NewWeeklyFigEventPageState extends State<NewWeeklyFigEventPage> {
  // 주차별 이벤트 참여 했는지 안했는지
  late bool hasWeek01Participated = false;
  late bool hasWeek02Participated = false;
  late bool hasWeek03Participated = false;
  // late bool hasWeek04Participated = false;

  @override
  void initState() {
    super.initState();
    final authState = BlocProvider.of<AuthBloc>(context).state;
    if (authState is SuccessAuthentication) {
      checkEventParticipation();
    }
  }

  Future<void> checkEventParticipation() async {
    // true -> 참여 기록 없음. 참여 가능
    // false -> 참여 기록 있음. 참여 불가능
    var week01 = await eventService.checkEventParticipation('2');
    var week02 = await eventService.checkEventParticipation('3');
    var week03 = await eventService.checkEventParticipation('4');
    // var week04 = await eventService.checkEventParticipation('5');
    setState(() {
      hasWeek01Participated = !week01.resp;
      hasWeek02Participated = !week02.resp;
      hasWeek03Participated = !week03.resp;
      // hasWeek04Participated = !week04.resp;
    });
    // print(hasWeek01Participated);
  }

  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;

    // 이벤트 기간 반영
    // 1.웰컴 2.스크랩 3.공유
    // 현재 날짜가 이벤트 기간 내 해당되면 버튼 활성화
    int week = 1;

    // 이벤트 참여 여부
    List<bool> getWeekCheckList = [
      hasWeek01Participated,
      hasWeek02Participated,
      hasWeek03Participated,
      // hasWeek04Participated
    ];

    List<String> challengeList = [
      "웰컴 청소년 톡talk",
      // "톡talk 알림 허용하기",
      "관심있는 정책 스크랩하기",
      "친구에게 정책 공유하기",
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: ThemeColors.third,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeColors.third, //Colors.white,
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
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
            child: Center(
                child: Column(
              children: [
                const TextCustom(text: '매주 달라지는 무화과 미션!'),
                SizedBox(
                  height: 15.h,
                ),
                StrokeText(
                  text: "주간 무화과 챌린지",
                  textStyle: TextStyle(
                      fontSize: 40.sp,
                      fontFamily: 'CookieRun',
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.primary),
                  strokeColor: Colors.transparent,
                  // strokeWidth: 2,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding: EdgeInsets.all(7.w),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(
                          245, 117, 33, 0.8), //ThemeColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextCustom(
                    text: '미션 참여하면 무화과 포인트 드려요',
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                InkWell(
                  onTap: () {
                    if (authState is LogOut) {
                      modalCheckLogin(context);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyFigHistoryPage(),
                          ));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1.r,
                          blurRadius: 2.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'images/Fig2.png',
                          width: 75.w,
                          height: 75.h,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                text: "영암군 특산물,",
                                fontWeight: FontWeight.w600,
                                color: ThemeColors.basic,
                                maxLines: 2,
                                height: 1.5.h,
                              ),
                              Row(
                                children: [
                                  TextCustom(
                                    text: "무화과 포인트",
                                    color: ThemeColors.primary,
                                    fontWeight: FontWeight.w800,
                                    maxLines: 2,
                                    height: 1.5.h,
                                  ),
                                  TextCustom(
                                    text: "를 모아보세요",
                                    color: ThemeColors.basic,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 2,
                                    height: 1.5.h,
                                  ),
                                ],
                              )
                            ])
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {
                    modalPreparing(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const FigMarketPage(),
                    //     ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1.r,
                          blurRadius: 2.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextCustom(
                                    text: "무화과 잡화점",
                                    color: ThemeColors.primary,
                                    fontWeight: FontWeight.w800,
                                    maxLines: 2,
                                    height: 1.5.h,
                                  ),
                                  TextCustom(
                                    text: "에서",
                                    color: ThemeColors.basic,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 2,
                                    height: 1.5.h,
                                  ),
                                ],
                              ),
                              TextCustom(
                                text: "포인트를 사용할 수 있어요",
                                fontWeight: FontWeight.w600,
                                color: ThemeColors.basic,
                                maxLines: 2,
                                height: 1.5.h,
                              ),
                            ]),
                        SvgPicture.asset(
                          'images/fig_shopping_cart.svg',
                          height: 75.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  padding: EdgeInsets.all(7.w),
                  color: Colors.transparent,
                  child: TextCustom(
                    text: '이번주 미션에 참여해보세요!',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Icon(
                  Icons.keyboard_double_arrow_down_rounded,
                  color: ThemeColors.primary,
                  size: 88.h,
                ),
                SizedBox(
                  height: 10.h,
                ),

                // 첫째주  - 웰컴 청소년톡talk
                challengeWidget(
                    text: week >= 1 ? challengeList[0] : "다음주 미션은 무엇일까요?",
                    imagePath: 'images/event_icon/icon_01.svg',
                    isEvent: week == 1 ? true : false,
                    week: week,
                    isPastEvent: week > 1,
                    isCheck: getWeekCheckList[0]),

                SizedBox(height: 27.h),
                // 둘째주  - 친구에게 정책 공유
                challengeWidget(
                    text: week >= 2 ? challengeList[1] : "다음주 미션은 무엇일까요?",
                    imagePath: 'images/event_icon/icon_02.svg',
                    isEvent: week == 2 ? true : false,
                    week: week,
                    isPastEvent: week > 2,
                    isCheck: getWeekCheckList[1]),
                SizedBox(height: 27.h),
                // 셋째주  - 친구에게 정책 스크랩
                challengeWidget(
                    text: week >= 3 ? challengeList[2] : "다음주 미션은 무엇일까요?",
                    imagePath: 'images/event_icon/icon_03.svg',
                    isEvent: week == 3 ? true : false,
                    week: week,
                    isPastEvent: week > 3,
                    isCheck: getWeekCheckList[2]),
                SizedBox(height: 27.h),
                // 넷째주  - 관심 있는 정책 스크랩
                // challengeWidget(
                //     text: week >= 4 ? challengeList[3] : "어떤 미션이 기다리고 있을까요?",
                //     imagePath: 'images/event_icon/icon_04.svg',
                //     isEvent: week == 4 ? true : false,
                //     week: week,
                //     isPastEvent: week > 4,
                //     isCheck: getWeekCheckList[3]),
                // SizedBox(height: 27.h),
                Container(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Divider(
                          color: ThemeColors.primary,
                          height: 30.h,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextCustom(
                          text: '꼭! 읽어보세요',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextCustom(
                          text: '주간 무화과 챌린지란?',
                          fontSize: 15.sp,
                          color: ThemeColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        TextCustom(
                          text: '   - 매주 새로 공개되는 미션 참여 시 무화과 포인트를 지급합니다.',
                          fontSize: 12.sp,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextCustom(
                          text:
                              '   - 미션 성공 시 무화과 포인트는 자동 지급되며\n     [마이 톡톡 > 무화과 지급 내역 페이지]에서 확인 가능합니다.',
                          fontSize: 12.sp,
                          maxLines: 2,
                          height: 1.5,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextCustom(
                          text: '   - 참여 대상 : 청소년 톡talk 회원',
                          fontSize: 12.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextCustom(
                          text: '   - 기간 : 2023.07.05~2023.08.01',
                          fontSize: 12.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextCustom(
                          text: '   - 현재 무화과 잡화점 서비스는 준비 중입니다.',
                          fontSize: 12.sp,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                      ]),
                ),
                // Image.asset(
                //   'images/yeongam_logo.jpg',
                //   width: 100.w,
                // )
              ],
            )),
          ),
        ));
  }

  Widget challengeWidget({
    required String text, // 이벤트 제목
    required String imagePath, // 아이콘 경로
    required int week, // 현재 주차
    required bool isEvent, // 이번주 이벤트
    required bool isPastEvent, // 종료된 이벤트
    bool isCheck = false, // 이벤트 참여 여부
  }) {
    if (isPastEvent && !isEvent) {
      // 종료된 이벤트 and 이번주 이벤트 아님
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
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
                  SvgPicture.asset(imagePath, width: 30.w),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10.w),
                  //   child:
                  // ),
                  SizedBox(
                    width: 20.w,
                  ),
                  TextCustom(text: text, color: Colors.black, fontSize: 15.sp),
                ],
              ),
            ),
          ),
          Container(
            width: 300.w,
            height: 50.h,
            decoration: BoxDecoration(
              border: Border.all(color: ThemeColors.primary, width: 2.w),
              color: const Color.fromRGBO(245, 117, 33, 0.6),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: TextCustom(
                    text: isCheck ? "완료" : "종료",
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          )
        ],
      );
    } else if (!isEvent) {
      // 이번주 이벤트 아님
      return Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(imagePath, width: 30.w),
              TextCustom(
                text: text,
                color: Colors.black,
                fontSize: 15.sp,
              ),
              Container(),
            ],
          ),
        ),
      );
    } else {
      // 이번주 이벤트
      return InkWell(
        onTap: () {
          // 해당 주차 페이지로 이동
          switch (week) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FirstWeekMissionPage(hasParticipated: isCheck),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SecondWeekMissionPage(hasParticipated: isCheck),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ThirdWeekMissionPage(hasParticipated: isCheck),
                ),
              );
              break;
            // case 4:
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) =>
            //           ThirdWeekMissionPage(hasParticipated: isCheck),
            //     ),
            //   );
            //   break;
            default:
              // 기본적으로 첫주차 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FirstWeekMissionPage(hasParticipated: isCheck),
                ),
              );
          }
        },
        child: Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(imagePath, width: 30.w),
                // SizedBox(
                //   width: 8.w,
                // ),
                isEvent
                    ? Text(text,
                        style: TextStyle(
                            fontFamily: "cookieRun",
                            color: Colors.black, //ThemeColors.fig_pink,
                            fontSize: 20.sp))
                    : TextCustom(
                        text: text, color: Colors.black, fontSize: 15.sp),
                isEvent
                    ? InkWell(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: ThemeColors.primary,
                          size: 20.sp,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      );
    }
  }
}
