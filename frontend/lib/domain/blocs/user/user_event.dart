part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class OnGetUserAuthenticationEvent extends UserEvent {}

class OnRegisterUserEvent extends UserEvent {
  final String user_id;
  final String user_name;
  final String user_email;
  final String userpw;
  final String userpw2;
  final String user_role;
  final String user_type;
  // final String invite_code;
  // final String phone_number;
  final String youthAge_code;
  final String parentsAge_code;
  final String emd_class_code;
  final String sex_class_code;

  OnRegisterUserEvent(
    this.user_id,
    this.user_name,
    this.user_email,
    this.userpw,
    this.userpw2,
    this.user_role,
    this.user_type,
    // this.invite_code,
    // this.phone_number,
    this.youthAge_code,
    this.parentsAge_code,
    this.emd_class_code,
    this.sex_class_code,
    // String string,
  );
}

class OnRegisterKakaoUserEvent extends UserEvent {
  final String user_id; // 회원번호
  final String user_name; // 닉네임
  final String user_email; // 이메일
  final String user_role; // 사용자
  final String user_type; // 선택안함
  // final String invite_code;
  final String youthAge_code; // 선택안함
  final String parentsAge_code; // 선택안함
  final String emd_class_code; // 선택안함
  final String sex_class_code; // 선택안함

  OnRegisterKakaoUserEvent(
      this.user_id,
      this.user_name,
      this.user_email,
      this.user_role,
      this.user_type,
      // this.invite_code,
      this.youthAge_code,
      this.parentsAge_code,
      this.emd_class_code,
      this.sex_class_code);
}

class OnVerifyEmailEvent extends UserEvent {
  final String user_email;
  final String code;

  OnVerifyEmailEvent(this.user_email, this.code);
}

class OnUpdateFigCountEvent extends UserEvent {
  final int newFigCount;
  OnUpdateFigCountEvent(this.newFigCount);
}

class OnEnterInviteCodeEvent extends UserEvent {
  final String inviteCode;
  OnEnterInviteCodeEvent(this.inviteCode);
}

// class OnUpdatePictureCover extends UserEvent {
//   final String pathCover;
//
//   OnUpdatePictureCover(this.pathCover);
// }

// class OnUpdatePictureProfile extends UserEvent {
//   final String pathProfile;
//
//   OnUpdatePictureProfile(this.pathProfile);
// }

// class OnUpdateProfileEvent extends UserEvent {
//   final String user;
//   final String description;
//   final String fullname;
//   final String phone;
//
//   OnUpdateProfileEvent(this.user, this.description, this.fullname, this.phone);
// }

class OnChangePasswordEvent extends UserEvent {
  final String currentPassword;
  final String newPassword;

  OnChangePasswordEvent(this.currentPassword, this.newPassword);
}

class OnChangeEmailEvent extends UserEvent {
  final String currentEmail;
  final String newEmail;
  OnChangeEmailEvent(this.currentEmail, this.newEmail);
}

class OnChangeExtraInfoEvent extends UserEvent {
  final String emd_class_code;
  final String youthAge_code;
  final String parentsAge_code;
  final String sex_class_code;
  OnChangeExtraInfoEvent(this.emd_class_code, this.youthAge_code,
      this.parentsAge_code, this.sex_class_code);
}

// class OnToggleButtonProfile extends UserEvent {
//   final bool isPhotos;
//
//   OnToggleButtonProfile(this.isPhotos);
// }

// class OnChangeAccountToPrivacy extends UserEvent {}

class OnLogOutUser extends UserEvent {}

// class OnAddNewFollowingEvent extends UserEvent {
//   final String uidFriend;
//
//   OnAddNewFollowingEvent(this.uidFriend);
// }

// class OnAcceptFollowerRequestEvent extends UserEvent {
//   final String uidFriend;
//   final String uidNotification;
//
//   OnAcceptFollowerRequestEvent(this.uidFriend, this.uidNotification);
// }

// class OnDeletefollowingEvent extends UserEvent {
//   final String uidUser;
//
//   OnDeletefollowingEvent(this.uidUser);
// }

// class OnDeletefollowersEvent extends UserEvent {
//   final String uidUser;
//
//   OnDeletefollowersEvent(this.uidUser);
// }



