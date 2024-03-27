import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:teentalktalk/data/storage/secure_storage.dart';
import 'package:teentalktalk/domain/blocs/user/user_bloc.dart';
import 'package:teentalktalk/domain/services/auth_services.dart';
import 'package:teentalktalk/domain/services/user_services.dart';
import 'package:teentalktalk/ui/helpers/kakao_sdk_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<OnLoginEvent>(_onLogin);
    on<OnKakaoLoginEvent>(_onKakaoLogin);
    on<OnCheckingLoginEvent>(_onCheckingLogin);
    on<OnLogOutEvent>(_onLogOut);
  }

  Future<void> _onLogin(
    OnLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // print("_onLogin");
      emit(LoadingAuthentication());
      // print("auth_bloc loadingAuthentication");
      // print(event.userid);
      // print(event.userpw);

      final data = await authService.login(event.userid, event.userpw);

      // print('_onLogin');
      // print(data.resp);
      await Future.delayed(const Duration(milliseconds: 350));

      if (data.resp) {
        await secureStorage.deleteSecureStorage();
        await secureStorage.persistenToken(data.token!);
        // print('_onLogin SuccessAuthentication');
        emit(SuccessAuthentication());
      } else {
        // print('_onLogin FailureAuthentication');
        // print(data.resp);
        emit(FailureAuthentication(data.message));
        // emit(FailureAuthentication());
      }
    } catch (e) {
      emit(FailureAuthentication(e.toString()));
      // emit(FailureAuthentication());
    }
  }

  Future<void> _onKakaoLogin(
      OnKakaoLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthentication());
      print("_onKakaoLogin");

      final data = await authService.kakaoLogin(event.userid, event.user_email);

      print(data.resp);
      await Future.delayed(const Duration(milliseconds: 350));

      if (data.resp) {
        await secureStorage.deleteSecureStorage();
        await secureStorage.persistenToken(data.token!);
        emit(SuccessAuthentication());
      } else {
        emit(FailureAuthentication(data.message));
      }
    } catch (e) {
      emit(FailureAuthentication(e.toString()));
    }
  }

  Future<void> _onCheckingLogin(
    OnCheckingLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 850));

      final token = await secureStorage.readToken();

      if (token != null) {
        // 사용자 토큰이 있ㅇ르 때 renewLogin 호출
        final data = await authService.renewLogin();

        if (data.resp) {
          // 토큰이 유효하고 사용자 정보를 받아온 경우
          final user = await userService.getUserById();

          if (user != null) {
            //사용자 정보가 유효한 경우 로그인 성공
            await secureStorage.persistenToken(data.token!);
            emit(SuccessAuthentication());
          } else {
            // 사용자 정보가 유효하지 않은 경우 로그아웃 처리
            await secureStorage.deleteSecureStorage();
            emit(LogOut());
          }
        } else {
          // 토큰이 유효하지 않은 경우 로그아웃 처리
          await secureStorage.deleteSecureStorage();
          emit(LogOut());
        }
      } else {
        // 토큰이 없는 경우 로그아웃 처리
        await secureStorage.deleteSecureStorage();
        emit(LogOut());
      }
    } catch (e) {
      // 예외 발생 시 로그아웃 처리
      await secureStorage.deleteSecureStorage();
      emit(LogOut());
    }
  }

  Future<void> _onLogOut(OnLogOutEvent event, Emitter<AuthState> emit) async {
    // print("_onLogOut");
    await secureStorage.deleteSecureStorage();
    emit(LogOut());
  }
}
