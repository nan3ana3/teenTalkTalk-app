import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/domain/blocs/auth/auth_bloc.dart';
import 'package:teentalktalk/domain/models/response/response_user_fig_count.dart';
import 'package:teentalktalk/domain/services/event_services.dart';
import 'package:teentalktalk/domain/services/user_services.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';
import 'package:teentalktalk/domain/models/response/response_fig_history.dart';

class MyFigHistoryPage extends StatefulWidget {
  const MyFigHistoryPage({Key? key}) : super(key: key);
  @override
  State<MyFigHistoryPage> createState() => _MyFigHistoryPageState();
}

class _MyFigHistoryPageState extends State<MyFigHistoryPage> {
  late String figCount = '-';

  @override
  initState() {
    super.initState();
    _updateFigCount();
  }

  Future<void> _updateFigCount() async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.state is SuccessAuthentication) {
      ResponseUserFigCount figCountData = await userService.updateFigCount();
      setState(() {
        figCount = figCountData.figCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: ThemeColors.primary),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const MyTalkTalkPage(),
              //     ),
              //     (_) => false);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 20.h,
                top: 20.h,
              ),
              child: const TextCustom(
                text: "무화과 지급내역",
                fontSize: 30,
                color: ThemeColors.basic,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.h),
              child: Container(
                padding: const EdgeInsets.all(30),
                height: 82.h,
                decoration: BoxDecoration(
                  color: ThemeColors.third,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SvgPicture.asset('images/Fig.svg'),
                    Image.asset('images/Fig2.png'),
                    TextCustom(
                      text: '$figCount개',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w900,
                      color: ThemeColors.basic,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.r),
            const Expanded(
              child: _FigHistory(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FigHistory extends StatefulWidget {
  const _FigHistory({Key? key}) : super(key: key);

  @override
  State<_FigHistory> createState() => _FigHistoryState();
}

class _FigHistoryState extends State<_FigHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // late Future<ResponseEvent> _figHistoryData;
  List<FigReward> figRewardList = [];
  List<FigUsage> figUsagedList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getFigHistory();
    //  _figHistoryData = eventService.getFigHistoryByUser();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _getFigHistory() async {
    ResponseFigHistory figHistoryData =
        await eventService.getFigHistoryByUser();
    setState(() {
      figRewardList = figHistoryData.rewardData;
      figUsagedList = figHistoryData.usageData;
      // print(figRewardList);
      // print(figUsagedList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: ThemeColors.basic,
          unselectedLabelColor: Colors.grey,
          indicatorColor: ThemeColors.primary,
          tabs: const <Widget>[
            Tab(
              child: TextCustom(
                text: '지급 내역',
                fontSize: 20,
              ),
            ),
            Tab(
              child: TextCustom(
                text: '사용 내역',
                fontSize: 20,
              ),
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFigRewardList(),
                _buildFigUsageList(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildFigRewardList() {
    return Scrollbar(
        child: ListView.builder(
            itemCount: figRewardList.length,
            itemBuilder: (context, index) {
              FigReward reward = figRewardList[index];
              return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(238, 238, 238, 1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 16.w, top: 26.h, bottom: 16.h),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                                text: reward.event_name,
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            SizedBox(height: 8.h),
                            TextCustom(
                              text: reward.acquired_time.substring(0, 10),
                              fontSize: 15,
                            )
                          ],
                        ),
                        const Spacer(),
                        // SvgPicture.asset('images/Fig.svg',
                        //     width: 20.w, height: 20.h),
                        Image.asset(
                          'images/Fig2.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 6.w),
                        Container(
                            margin: EdgeInsets.only(right: 16.w),
                            child: TextCustom(
                                text: reward.fig_payment, //"500",
                                fontSize: 15.sp,
                                color: Colors.black))
                      ],
                    ),
                  ));
            }));
  }

  Widget _buildFigUsageList() {
    return Scrollbar(
        child: ListView.builder(
            itemCount: figUsagedList.length,
            itemBuilder: (context, index) {
              FigUsage usage = figUsagedList[index];
              return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(238, 238, 238, 1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 16.w, top: 26.h, bottom: 16.h),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                                text: usage.product_name, //"출석 체크",
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            SizedBox(height: 8.h),
                            TextCustom(
                              text: usage.fig_used_date
                                  .substring(0, 10), //"2023.03.24 13:44",
                              fontSize: 15,
                            )
                          ],
                        ),
                        const Spacer(),
                        // SvgPicture.asset('images/Fig.svg',
                        //     width: 20.w, height: 20.h),
                        Image.asset(
                          'images/Fig2.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 6.w),
                        Container(
                            margin: EdgeInsets.only(right: 16.w),
                            child: TextCustom(
                                text: usage.product_cost, //"500",
                                fontSize: 15.sp,
                                color: Colors.black))
                      ],
                    ),
                  ));
            }));
  }
}
