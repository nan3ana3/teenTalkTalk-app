// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:teentalktalk/data/env/env.dart';
// import 'package:teentalktalk/domain/blocs/policy/policy_bloc.dart';
// import 'package:teentalktalk/domain/models/response/response_policy.dart';
// import 'package:teentalktalk/domain/models/response/response_search.dart';
// import 'package:teentalktalk/domain/services/policy_services.dart';
// import 'package:teentalktalk/domain/services/user_services.dart';
// import 'package:teentalktalk/ui/helpers/helpers.dart';
// // import 'package:teentalktalk/domain/models/response/response_search.dart';
// import 'package:teentalktalk/ui/screens/policy/policy_detail.dart';
// import 'package:teentalktalk/ui/screens/policy/policy_list_X.dart';
// import 'package:teentalktalk/ui/themes/theme_colors.dart';
// import 'package:teentalktalk/ui/widgets/widgets.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   late TextEditingController _searchController;
//   late FocusNode myFocusNode;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//     myFocusNode = FocusNode();
//   }

//   @override
//   void dispose() {
//     _searchController.clear();
//     _searchController.dispose();
//     myFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final policyBloc = BlocProvider.of<PolicyBloc>(context);
//     String inputText = "";

//     return Scaffold(
//       // backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: ThemeColors.primary,
//         toolbarHeight: 10,
//         elevation: 0,
//         // leading: IconButton(
//         //   icon:
//         //       const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
//         //   onPressed: () => Navigator.pop(context),
//         // ),
//       ),
//       body: SafeArea(
//         child: ListView(
//           physics: const BouncingScrollPhysics(),
//           // padding: const EdgeInsets.only(top: 10.0),
//           children: [
//             Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: Container(
//                     padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
//                     color: ThemeColors.primary,
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.arrow_back_ios_new_rounded,
//                             color: ThemeColors.darkGreen,
//                           ),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         Container(
//                           padding:
//                               const EdgeInsets.only(left: 10.0, right: 10.0),
//                           height: 45,
//                           width: size.width / 1.2,
//                           decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(10.0)),
//                           child: BlocBuilder<PolicyBloc, PolicyState>(
//                             builder: (context, state) => TextField(
//                               textInputAction: TextInputAction.go,
//                               onSubmitted: (value) {
//                                 inputText = value;
//                                 // setState(() {
//                                 //   Navigator.push(
//                                 //       context,
//                                 //       routeSlide(
//                                 //           page: PolicyListPage(inputText)));
//                                 // });
//                               },
//                               focusNode: myFocusNode,
//                               autofocus: false,
//                               controller: _searchController,
//                               onChanged: (value) {
//                                 // print(value);
//                                 if (value.isNotEmpty) {
//                                   policyBloc.add(OnIsSearchPolicyEvent(true));
//                                   policyService.searchPolicy(value);
//                                 } else {
//                                   policyBloc.add(OnIsSearchPolicyEvent(false));
//                                 }
//                               },
//                               cursorColor: ThemeColors.darkGreen,
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: '복지 검색',
//                                   // hintStyle: GoogleFonts.roboto(fontSize: 17),
//                                   suffixIcon: myFocusNode.hasFocus
//                                       ? IconButton(
//                                           icon: const Icon(
//                                             Icons.cancel,
//                                             size: 20,
//                                             color: ThemeColors.darkGreen,
//                                           ),
//                                           onPressed: () {
//                                             setState(() {
//                                               _searchController.clear();
//                                               // _searchText = "";
//                                               myFocusNode.unfocus();
//                                             });
//                                           },
//                                         )
//                                       : IconButton(
//                                           icon: const Icon(
//                                             Icons.search_rounded,
//                                             color: ThemeColors.darkGreen,
//                                           ),
//                                           onPressed: () {},
//                                           // onPressed: () => Navigator.push(
//                                           //   context,
//                                           //   MaterialPageRoute(
//                                           //     builder: (context) =>
//                                           //         const PolicyListPage(),
//                                           //   ),
//                                           // ),
//                                         )),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ))),
//             const SizedBox(height: 10.0),
//             BlocBuilder<PolicyBloc, PolicyState>(
//                 buildWhen: (previous, current) => previous != current,
//                 builder: (context, state) => !state.isSearchPolicy
//                     ? FutureBuilder<List<Policy>>(
//                         future: policyService.getAllPolicyForSearch(),
//                         builder: (_, snapshot) {
//                           if (snapshot.data != null && snapshot.data!.isEmpty) {
//                             return _ListWithoutPolicySearch();
//                           }

//                           return !snapshot.hasData
//                               ? const _ShimerSearch()
//                               : _ListPolicySearch(policies: snapshot.data!);
//                         },
//                       )
//                     : streamSearchPolicy())
//           ],
//         ),
//       ),
//     );
//   }

//   Widget streamSearchPolicy() {
//     return StreamBuilder<List<Policy>>(
//       stream: policyService.searchProducts,
//       builder: (context, snapshot) {
//         if (snapshot.data == null) return Container();

//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.data!.isEmpty) {
//           return ListTile(
//             title: Text(
//               '${_searchController.text}에 대한 검색 결과 없음',
//               style: const TextStyle(color: ThemeColors.basic),
//             ),
//           );
//         }

//         return _ListPolicySearch(policies: snapshot.data!);
//       },
//     );
//   }
// }

// class _ListPolicySearch extends StatelessWidget {
//   final List<Policy> policies;
//   const _ListPolicySearch({Key? key, required this.policies}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: policies.length,
//         itemBuilder: (context, i) {
//           final String imgName = policies[i].img;

//           final String imgUrl = "images/policy/$imgName";
//           // "app/src/public/upload/policy/$imgName";

//           final String startDateYear =
//               policies[i].application_start_date.substring(0, 4);
//           final String endDateYear =
//               policies[i].application_end_date.substring(0, 4);
//           final String startDateMonth =
//               policies[i].application_start_date.substring(5, 7);
//           final String endDateMonth =
//               policies[i].application_end_date.substring(5, 7);
//           final String startDateDay =
//               policies[i].application_start_date.substring(8, 10);
//           final String endDateDay =
//               policies[i].application_end_date.substring(8, 10);
//           final String startDate =
//               '$startDateYear.$startDateMonth.$startDateDay';
//           final String endDate = '$endDateYear.$endDateMonth.$endDateDay';

//           return Padding(
//               padding: const EdgeInsets.fromLTRB(3, 3, 3, 0), // 카드 바깥쪽
//               child: Card(
//                 child: Padding(
//                     padding: const EdgeInsets.all(7), // 카드 안쪽
//                     child: InkWell(
//                         splashColor: ThemeColors.primary.withAlpha(30),
//                         onTap: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     DetailPolicyPage(policies[i]),
//                               ),
//                             ),
//                         child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.all(0),
//                                 child: SizedBox(
//                                   // 이미지
//                                   width: 80.0,
//                                   height: 80.0,
//                                   child: Image(
//                                     image: AssetImage(imgUrl),
//                                     fit: BoxFit.fitWidth,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                   child: Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           10, 0, 10, 0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Text(
//                                             policies[i].policy_institution_code,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 color: ThemeColors.basic),
//                                           ), // 주최측
//                                           const SizedBox(
//                                             height: 3,
//                                           ),
//                                           Text(
//                                             policies[i].policy_name,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold),
//                                           ), // 정책 제목
//                                           Container(
//                                             margin:
//                                                 const EdgeInsets.only(top: 5),
//                                             padding: const EdgeInsets.all(3),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               color: ThemeColors.secondary,
//                                             ),
//                                             child: Text(
//                                               '$startDate ~ $endDate',
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: const TextStyle(
//                                                   fontSize: 10.0,
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                           ) // 모집 기간
//                                         ],
//                                       ))),
//                               SizedBox(
//                                 // decoration: BoxDecoration(color: Colors.grey[350]),
//                                 width: 80.0,
//                                 height: 80.0,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.bookmark_border,
//                                         size: 30,
//                                         color: ThemeColors.basic,
//                                       ),
//                                       onPressed: () {},
//                                     ),
//                                     const Text('0',
//                                         style: TextStyle(
//                                             color: ThemeColors.basic,
//                                             fontSize: 10))
//                                   ],
//                                 ),
//                               ),
//                             ]))),
//               ));
//         });
//   }
// }

// class _ShimerSearch extends StatelessWidget {
//   const _ShimerSearch({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: const [
//         ShimmerNaru(),
//         SizedBox(height: 10.0),
//         ShimmerNaru(),
//         SizedBox(height: 10.0),
//         ShimmerNaru(),
//       ],
//     );
//   }
// }

// class _ListWithoutPolicySearch extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final size = MediaQuery.of(context).size;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: const [
//         TextCustom(text: "등록된 정책이 없습니다."),
//       ],
//     );
//   }
// }
