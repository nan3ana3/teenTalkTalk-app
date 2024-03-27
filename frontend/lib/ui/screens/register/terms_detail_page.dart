import 'package:flutter/material.dart';
import 'package:teentalktalk/domain/models/response/response_terms.dart';
import 'package:teentalktalk/domain/services/dataif_services.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class termsDetailPage extends StatefulWidget {
  final int termsCode;
  const termsDetailPage({Key? key, required this.termsCode}) : super(key: key);

  @override
  State<termsDetailPage> createState() => _termsDetailPageState();
}

class _termsDetailPageState extends State<termsDetailPage> {
  late Future<ResponseTerms> _termsDataFuture;
  late String title = '';

  @override
  void initState() {
    super.initState();
    _termsDataFuture = dataIfService.getTermsData();
  }

  @override
  Widget build(BuildContext context) {
    final int termsCode = widget.termsCode;
    // print(termsCode);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<ResponseTerms>(
        future: _termsDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String content = '';
            if (termsCode == 0) {
              content = snapshot.data!.termsData.first.terms;
              title = '회원가입 이용 약관';
            } else if (termsCode == 1) {
              content = snapshot.data!.termsData.first.privacy;
              title = '개인 정보 처리 방침';
            }
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        text: title,
                        color: ThemeColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextCustom(
                        text: content,
                        maxLines: content.length,
                        fontSize: 12,
                        height: 2,
                      )
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
