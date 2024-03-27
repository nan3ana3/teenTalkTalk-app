import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/env/env.dart';
import 'package:teentalktalk/domain/models/response/response_banner.dart';

class BannerServices {
  Map<String, String> _setHeaders() =>
      {'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8'};

  Future<List<Banners>> getBannerData() async {
    // print('get banner data');
    final resp = await http.get(Uri.parse('${Environment.urlApi}/main/banner'),
        headers: _setHeaders());
    // print(resp.body);

    return ResponseBanner.fromJson(jsonDecode(resp.body)).banners;
  }
}

final bannerService = BannerServices();
