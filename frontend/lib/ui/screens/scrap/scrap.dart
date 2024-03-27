import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teentalktalk/data/env/env.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/domain/models/response/response_policy.dart';
import 'package:teentalktalk/domain/services/event_services.dart';
import 'package:teentalktalk/domain/services/policy_services.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_checkLogin.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_getFig.dart';
import 'package:teentalktalk/ui/screens/login/login_page.dart';
import 'package:teentalktalk/ui/screens/login/no_login_page.dart';
import 'package:teentalktalk/ui/screens/policy/policy_detail_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ScrapPage extends StatefulWidget {
  const ScrapPage({Key? key}) : super(key: key);

  @override
  State<ScrapPage> createState() => _ScrapPageState();
}

class _ScrapPageState extends State<ScrapPage> {
  late bool _isFirstScrap = false;
  // late int _scrappedPolicyCount = 0;

  @override
  void initState() {
    super.initState();
    final authState = BlocProvider.of<AuthBloc>(context).state;

    if (authState is SuccessAuthentication) {
      _checkFirstScrap();
    }
  }

  Future<void> _checkFirstScrap() async {
    var resp = await eventService.checkEventParticipation('3');
    setState(() {
      _isFirstScrap = resp.resp;
    });

    if (_isFirstScrap) {
      _giveFigIfScrappedPolicyExists();
    }
  }

  Future<void> _giveFigIfScrappedPolicyExists() async {
    var policies = await policyService.getScrappedPolicy();
    if (policies.isNotEmpty) {
      eventService.giveFigForWeeklyFigChallenge('3');
      // ignore: use_build_context_synchronously
      modalGetFig(context, '3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.transparent,
        canvasColor: Colors.transparent,
      ),
      home: Scaffold(
        backgroundColor: ThemeColors.third,
        appBar: AppBar(
          titleSpacing: 0,
          title: const Text(
            '스크랩',
            style: TextStyle(
              color: ThemeColors.primary,
              fontFamily: 'CookieRun',
              fontSize: 24,
            ),
          ),
          leading: InkWell(
            // onTap: () =>
            //     Navigator.push(context, routeSlide(page: const LoginPage())),
            child: Image.asset(
              'images/aco.png',
              height: 70,
            ),
          ),
          backgroundColor: Colors.white, //ThemeColors.primary,
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 10),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is SuccessAuthentication) {
                          return BlocBuilder<PolicyBloc, PolicyState>(
                              builder: (((context, state) =>
                                  FutureBuilder<List<Policy>>(
                                      future: policyService.getScrappedPolicy(),
                                      builder: ((_, snapshot) {
                                        if (snapshot.data != null &&
                                            snapshot.data!.isEmpty) {
                                          return _ListWithoutPolicy();
                                        }

                                        if (!snapshot.hasData) {
                                          return const _ShimerLoading();
                                        } else {
                                          // _scrappedPolicyCount =
                                          //     snapshot.data!.length;

                                          // if (_isFirstScrap &&
                                          //     _scrappedPolicyCount >= 1) {
                                          //   eventService
                                          //       .giveFigForWeeklyFigChallenge(
                                          //           '3');
                                          //   // ignore: use_build_context_synchronously
                                          //   modalGetFig(context, '3');
                                          // }

                                          return ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.length,
                                              // snapshot.data!.length,
                                              itemBuilder: (_, i) =>
                                                  ListViewPolicy(
                                                    policies: snapshot.data![i],
                                                  ));
                                        }
                                      })))));
                        } else {
                          // modalCheckLogin(context);

                          return Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/aco3.png',
                                    // width: 300,
                                    height: size.height / 3, //300,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      NeumorphicButton(
                                        style: NeumorphicStyle(
                                            shape: NeumorphicShape.flat,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(20)),
                                            depth: 2,
                                            lightSource: LightSource.topLeft,
                                            color: ThemeColors.primary),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              routeSlide(
                                                  page: const LoginPage()));
                                          // Navigator.push(
                                          //     context,
                                          //     routeSlide(
                                          //         page: const NoLoginPage()));
                                        },
                                        child: const TextCustom(
                                          text: '로그인',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextCustom(
                                          text: ' 해주세요', fontSize: 20),
                                    ],
                                  )
                                ]),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigation(index: 3),
      ),
    );
  }
}

// 정책 리스트
class ListViewPolicy extends StatefulWidget {
  final Policy policies;

  // final Map<String, dynamic> codeData;
  // final Future<dynamic> codeData;

  // final String categoryCode;
  const ListViewPolicy({
    Key? key,
    required this.policies,

    // required this.codeData
  }) : super(key: key);

  @override
  State<ListViewPolicy> createState() => _ListViewPolicyState();
}

class _ListViewPolicyState extends State<ListViewPolicy> {
  @override
  Widget build(BuildContext context) {
    final Policy policies = widget.policies;

    // 기관
    final String policyInstitution = getMobileCodeService.getCodeDetailName(
        "policy_institution_code", policies.policy_institution_code);
    // 제목
    final String policyName = policies.policy_name;
    // 분야
    final String policyField = getMobileCodeService
        .getCodeDetailName("policy_field_code", policies.policy_field_code)
        .toString();

    // 이미지
    final String imgName = policies.img;
    final String imgUrl = '${Environment.urlApiServer}/upload/policy/$imgName';

    // 모집 기간
    final String startDateYear =
        policies.application_start_date.substring(0, 4);
    final String endDateYear = policies.application_end_date.substring(0, 4);
    final String startDateMonth =
        policies.application_start_date.substring(5, 7);
    final String endDateMonth = policies.application_end_date.substring(5, 7);
    final String startDateDay =
        policies.application_start_date.substring(8, 10);
    final String endDateDay = policies.application_end_date.substring(8, 10);
    final String startDate = '$startDateYear.$startDateMonth.$startDateDay';
    final String endDate = '$endDateYear.$endDateMonth.$endDateDay';

    return Padding(
        padding: const EdgeInsets.fromLTRB(3, 3, 3, 0), // 카드 바깥쪽
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(7), // 카드 안쪽
              child: InkWell(
                  splashColor: ThemeColors.primary.withAlpha(30),
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPolicyPage(policies),
                        ),
                      ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: SizedBox(
                            // 이미지
                            width: 80.0,
                            height: 80.0,
                            child: Image.network(
                              imgUrl,
                              fit: BoxFit.fill,
                            ),
                            // Image(
                            //   image: AssetImage(imgUrl),
                            //   fit: BoxFit.fitWidth,
                            // ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // 주최 기관
                                    TextCustom(
                                      text: policyInstitution,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12.0,
                                      color: ThemeColors.basic,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    // 정책 제목
                                    TextCustom(
                                      text: policyName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // 모집 기간
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 2, bottom: 2),
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ThemeColors.secondary,
                                      ),
                                      child: TextCustom(
                                        text: '$startDate ~ $endDate',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 10.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    // 카테고리
                                    TextCustom(
                                      text: policyField,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                    ),
                                  ],
                                ))),
                        SizedBox(
                          width: 50,
                          height: 80,
                          child: _ScrapUnscrap(
                            uidPolicy: policies.pid,
                            countScraps: policies.count_scraps,
                          ),
                        )

                        // Expanded(
                        //   flex: 1,
                        //   child: _ScrapUnscrap(
                        //     uidPolicy: policies.board_idx.toString(),
                        //     isScrapped: policies.is_scrap,
                        //     countScraps: policies.count_scraps,
                        //   ),
                        // ),
                      ]))),
        ));
  }
}

// 정책 스크랩
class _ScrapUnscrap extends StatefulWidget {
  final String uidPolicy; // 정책 고유번호
  final int countScraps; // 스크랩 수

  const _ScrapUnscrap({
    Key? key,
    required this.uidPolicy,
    // required this.uidUser,
    required this.countScraps,
  }) : super(key: key);
  @override
  State<_ScrapUnscrap> createState() => _ScrapUnscrapState();
}

class _ScrapUnscrapState extends State<_ScrapUnscrap> {
  bool _isScrapped = false;

  @override
  void initState() {
    super.initState();
    _loadScrappedStatus();
  }

  Future<void> _loadScrappedStatus() async {
    final authState = BlocProvider.of<AuthBloc>(context).state;
    if (authState is SuccessAuthentication) {
      final uidPolicy = widget.uidPolicy;
      final isScrapped = await policyService.checkPolicyScrapped(uidPolicy);
      setState(() {
        _isScrapped = isScrapped == 1;
      });
    } else {
      setState(() {
        _isScrapped = false;
      });
    }
  }

  Future<void> _handleScrapUnscrap() async {
    final policyBloc = BlocProvider.of<PolicyBloc>(context);
    final authState = BlocProvider.of<AuthBloc>(context).state;
    final userState = BlocProvider.of<UserBloc>(context).state;
    final uidUser = userState.user?.uid;
    final uidPolicy = widget.uidPolicy;

    if (authState is SuccessAuthentication) {
      if (uidUser != null) {
        policyBloc.add(
          OnScrapOrUnscrapPolicy(uidPolicy, uidUser),
        );
        setState(() {
          _isScrapped = !_isScrapped;
        });
      }
    } else {
      modalCheckLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final policyBloc = BlocProvider.of<PolicyBloc>(context);
    final authState = BlocProvider.of<AuthBloc>(context).state;
    final userState = BlocProvider.of<UserBloc>(context).state;
    final uidUser = userState.user?.uid;
    final uidPolicy = widget.uidPolicy;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (authState is SuccessAuthentication) {
              if (uidUser != null) {
                policyBloc.add(
                  OnScrapOrUnscrapPolicy(uidPolicy, uidUser),
                );
                setState(() {
                  _isScrapped = !_isScrapped;
                  print(_isScrapped);
                });
              }
            } else {
              modalCheckLogin(context);
            }
          },
          icon: Icon(
            Icons
                .bookmark, //_isScrapped ? Icons.bookmark : Icons.bookmark_border_outlined,
            color: authState is LogOut
                ? ThemeColors.basic
                : ThemeColors
                    .primary, //(_isScrapped ? ThemeColors.primary : ThemeColors.basic),
            size: 30,
          ),
        ),
        TextCustom(
          text: widget.countScraps.toString(),
          color: ThemeColors.basic,
          fontSize: 10,
        ),
      ],
    );
  }
}

// 스크랩한 정책 없을 때
class _ListWithoutPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/aco3.png',
            width: 300,
            height: 300,
          ),
          const TextCustom(text: '스크랩한 정책이 없어요', fontSize: 20),
        ],
      ),
    );
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
