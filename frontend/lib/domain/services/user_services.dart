import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/env/env.dart';
import 'package:teentalktalk/domain/models/response/response_user_fig_count.dart';
import 'package:teentalktalk/domain/models/response/response_fig_history.dart';
import 'package:teentalktalk/ui/helpers/debouncer.dart';
import 'package:teentalktalk/data/storage/secure_storage.dart';
import 'package:teentalktalk/domain/models/response/default_response.dart';
// import 'package:teentalktalk/domain/models/response/response_followers.dart';
// import 'package:teentalktalk/domain/models/response/response_followings.dart';
import 'package:teentalktalk/domain/models/response/response_user.dart';

class UserServices {
  final debouncer = DeBouncer(duration: const Duration(milliseconds: 800));
  // final StreamController<List<UserFind>> _streamController =
  //     StreamController<List<UserFind>>.broadcast();
  // Stream<List<UserFind>> get searchProducts => _streamController.stream;

  // void dispose() {
  //   _streamController.close();
  // }

  Future<DefaultResponse> createdUser(
    String userid,
    String userName,
    String userEmail,
    String userpw,
    String userpw2,
    String userRole,
    String userType,
    // String inviteCode,
    String youthageCode,
    String parentsageCode,
    String emdClassCode,
    String sexClassCode,
  ) async {
    final resp = await http
        .post(Uri.parse('${Environment.urlApi}/login/signup'), headers: {
      'Accept': 'application/json'
    }, body: {
      'userid': userid,
      'user_name': userName,
      'user_email': userEmail,
      'userpw': userpw,
      'userpw2': userpw2,
      'user_role': userRole,
      'user_type': userType,
      // 'invite_code': inviteCode,
      'youthAge_code': youthageCode,
      'parentsAge_code': parentsageCode,
      'emd_class_code': emdClassCode,
      'sex_class_code': sexClassCode
    });
    // print('${Environment.urlApi}/signup');
    // print(resp.body);

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> createdKakaoUser(
    String userid, // 회원번호
    String userName,
    String userEmail,
    String userRole, //기본 - 선택 X
    String userType, //기본 - 선택 X
    // String inviteCode,
    String youthageCode, //기본 - 선택 X
    String parentsageCode, //기본 - 선택 X
    String emdClassCode, //기본 - 선택 X
    String sexClassCode, //기본 - 선택 X
  ) async {
    final resp = await http
        .post(Uri.parse('${Environment.urlApi}/login/kakao-signup'), headers: {
      'Accept': 'application/json'
    }, body: {
      'userid': userid,
      'user_name': userName,
      'user_email': userEmail,
      // 'userpw': userpw,
      // 'userpw2': userpw2,
      'user_role': userRole,
      'user_type': userType,
      // 'invite_code': inviteCode,
      'youthAge_code': youthageCode,
      'parentsAge_code': parentsageCode,
      'emd_class_code': emdClassCode,
      'sex_class_code': sexClassCode
    });
    // print('${Environment.urlApi}/signup');
    // print(resp.body);

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseUser> getUserById() async {
    final token = await secureStorage.readToken();
    // print(token);
    // print('ResponseUser - getUserById');
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/user/get-user-by-id'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    // print(resp.body);
    return ResponseUser.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> verifyEmail(String email, String code) async {
    print(email);
    print(code);
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/verify-email/$code/$email'),
        headers: {'Accept': 'application/json'});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> changePassword(
      String currentPass, String newPass) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${Environment.urlApi}/user/change-password'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'currentPassword': currentPass, 'newPassword': newPass});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> changeEmail(
      String currentPass, String newPass) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${Environment.urlApi}/user/change-email'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'currentEmail': currentPass, 'newEmail': newPass});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> changeExtraInfo(
      String emd, String youthAge, String parentsAge, String sex) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${Environment.urlApi}/user/change-extra-info'),
        headers: {
          'Accept': 'application/json',
          'xxx-token': token!
        },
        body: {
          'emd_class_code': emd,
          'youthAge_code': youthAge,
          'parentsAge_code': parentsAge,
          'sex_class_code': sex
        });

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  // tb_user에서 사용자 무화과 개수 가져오기/업데이트
  Future<ResponseUserFigCount> updateFigCount() async {
    final token = await secureStorage.readToken();

    // print('getFigCount');
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/user/get-fig-count'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    // print(resp.body);

    return ResponseUserFigCount.fromJson(jsonDecode(resp.body));
  }

  // 탈퇴 사유 내역 기록
  Future<DefaultResponse> saveWithdrawalLog(String code, String etc) async {
    final token = await secureStorage.readToken();
    // print("saveWithdrawalLog");
    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/user/save-withdrawal-log'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'withdrawal_reason_code': code, 'etc': etc});
    // print(resp.body);
    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  // 사용자 탈퇴
  Future<DefaultResponse> deleteUser() async {
    final token = await secureStorage.readToken();
    // print(token);
    // print('ResponseUser - getUserById');
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/user/delete-user'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }
}

final userService = UserServices();
