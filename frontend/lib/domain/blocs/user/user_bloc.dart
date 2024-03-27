// ignore_for_file: depend_on_referenced_packages

// import 'dart:html';
// import 'dart:js';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
import 'package:teentalktalk/domain/models/response/response_user.dart';
import 'package:teentalktalk/domain/services/event_services.dart';
import 'package:teentalktalk/domain/services/user_services.dart';

// import 'package:teentalktalk/ui/popup/register/register_success.dart';
// import '../../../ui/themes/theme_colors.dart';
// import '../../../ui/widgets/widgets.dart';
// import '../../services/user_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<OnGetUserAuthenticationEvent>(_onGetUserAuthentication);
    on<OnRegisterUserEvent>(_onRegisterUser);
    on<OnRegisterKakaoUserEvent>(_onRegisterKakaoUser);
    on<OnVerifyEmailEvent>(_onVerifyEmail);
    on<OnChangePasswordEvent>(_changePassword);
    on<OnChangeEmailEvent>(_changeEmail);
    on<OnChangeExtraInfoEvent>(_changeExtraInfo);
    on<OnEnterInviteCodeEvent>(_enterInviteCode);
    on<OnLogOutUser>(_logOutAuth);
  }

  Future<void> _onGetUserAuthentication(
      OnGetUserAuthenticationEvent event, Emitter<UserState> emit) async {
    try {
      final data = await userService.getUserById();
      print('_onGetUserAuthentication');
      emit(state.copyWith(user: data.user));
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onRegisterUser(
      OnRegisterUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      await Future.delayed(const Duration(milliseconds: 550));
      // print("event.user_id: ${event.user_id}");
      final resp = await userService.createdUser(
          event.user_id,
          event.user_name,
          event.user_email,
          event.userpw,
          event.userpw2,
          event.user_role,
          event.user_type,
          // event.invite_code,
          event.youthAge_code,
          event.parentsAge_code,
          event.emd_class_code,
          event.sex_class_code);
      // print(event);
      // print(resp.resp);
      // print(resp.message);
      // print(resp.resp);

      if (resp.resp) {
        emit(SuccessUserState());
      } else {
        emit(FailureUserState(resp.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onRegisterKakaoUser(
      OnRegisterKakaoUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      await Future.delayed(const Duration(milliseconds: 550));
      print("_onRegisterKakaoUser ${event.user_name}");
      final resp = await userService.createdKakaoUser(
          event.user_id,
          event.user_name,
          event.user_email,
          // event.userpw,
          // event.userpw2,
          event.user_role,
          event.user_type,
          // event.invite_code,
          event.youthAge_code,
          event.parentsAge_code,
          event.emd_class_code,
          event.sex_class_code);
      // print(event);
      // print(resp.resp);
      // print(resp.message);
      // print(resp.resp);

      if (resp.resp) {
        emit(SuccessKakaoUserState());
      } else {
        emit(FailureUserState(resp.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onVerifyEmail(
      OnVerifyEmailEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());
      print("_onVerifyEmail");

      final resp = await userService.verifyEmail(event.user_email, event.code);

      await Future.delayed(const Duration(milliseconds: 350));

      if (resp.resp) {
        emit(SuccessUserState());
      } else {
        emit(FailureUserState(resp.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _changePassword(
      OnChangePasswordEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data = await userService.changePassword(
          event.currentPassword, event.newPassword);

      await Future.delayed(const Duration(milliseconds: 450));
      // print(data.resp);

      final dataUser = await userService.getUserById();

      if (data.resp) {
        emit(SuccessUserState());
        emit(state.copyWith(user: dataUser.user));
      } else {
        emit(FailureUserState(data.message));
        emit(state.copyWith(user: dataUser.user));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  // Future<void> _changePassword( OnChangePasswordEvent event, Emitter<UserState> emit ) async {

  //   try {

  //     emit( LoadingUserState() );

  //     final data = await userService.changePassword(event.currentPassword, event.newPassword);

  //     await Future.delayed(const Duration(milliseconds: 450));

  //     final dataUser = await userService.getUserById();

  //     if( data.resp ){

  //       emit( SuccessUserState() );

  //       emit( state.copyWith(user: dataUser.user, postsUser: dataUser.postsUser));

  //     }else{

  //       emit( FailureUserState(data.message) );

  //       emit( state.copyWith(user: dataUser.user, postsUser: dataUser.postsUser));

  //     }

  //   } catch (e) {
  //     emit(FailureUserState(e.toString()));
  //   }

  // }

  Future<void> _changeEmail(
      OnChangeEmailEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data =
          await userService.changeEmail(event.currentEmail, event.newEmail);

      await Future.delayed(const Duration(milliseconds: 450));

      final dataUser = await userService.getUserById();

      if (data.resp) {
        emit(SuccessUserState());

        emit(state.copyWith(user: dataUser.user));
      } else {
        emit(FailureUserState(data.message));

        emit(state.copyWith(user: dataUser.user));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _changeExtraInfo(
      OnChangeExtraInfoEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data = await userService.changeExtraInfo(event.emd_class_code,
          event.youthAge_code, event.parentsAge_code, event.sex_class_code);

      await Future.delayed(const Duration(milliseconds: 450));

      final dataUser = await userService.getUserById();

      if (data.resp) {
        emit(SuccessUserState());

        emit(state.copyWith(user: dataUser.user));
      } else {
        emit(FailureUserState(data.message));

        emit(state.copyWith(user: dataUser.user));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _enterInviteCode(
      OnEnterInviteCodeEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());
      final data = await eventService.giveFigForInvitation(event.inviteCode);
      await Future.delayed(const Duration(milliseconds: 450));
      // print(data.resp);
      final dataUser = await userService.getUserById();

      if (data.resp) {
        emit(SuccessUserState());

        emit(state.copyWith(user: dataUser.user));
      } else {
        emit(FailureUserState(data.message));

        emit(state.copyWith(user: dataUser.user));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _logOutAuth(OnLogOutUser event, Emitter<UserState> emit) async {
    // print('_logOutAuth');
    emit(state.copyWith(user: null));
  }
}
