import 'dart:convert';

ResponseUser responseUserFromJson(String str) =>
    ResponseUser.fromJson(json.decode(str));

String responseUserToJson(ResponseUser data) => json.encode(data.toJson());

class ResponseUser {
  bool resp;
  String message;
  User user;
  // List<User> user;
  // PostsUser postsUser;

  ResponseUser({
    required this.resp,
    required this.message,
    required this.user,
    // required this.postsUser,
  });

  factory ResponseUser.fromJson(Map<String, dynamic> json) => ResponseUser(
        resp: json["resp"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        // user: List<User>.from(json["user"].map((x) => User.fromJson(x))),

        // postsUser: PostsUser.fromJson(json["posts"]),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  String uid;
  String userid;
  String userpw;
  String user_name;
  String user_email;
  String user_type;
  String youthAge_code;
  String parentsAge_code;
  String sex_class_code;
  String emd_class_code;
  String fig;

  // String phone_no;

  User({
    required this.uid,
    required this.userid,
    required this.userpw,
    required this.user_name,
    required this.user_email,
    required this.user_type,
    required this.youthAge_code,
    required this.parentsAge_code,
    required this.sex_class_code,
    required this.emd_class_code,
    required this.fig,
    // required this.phone_no,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"] ?? '',
        userid: json["userid"] ?? '',
        userpw: json["userpw"] ?? '',
        user_name: json["user_name"] ?? '',
        user_email: json["user_email"] ?? '',
        user_type: json["user_type"] ?? '',
        youthAge_code: json["youthAge_code"] ?? '',
        parentsAge_code: json["parentsAge_code"] ?? '',
        sex_class_code: json["sex_class_code"] ?? '',
        emd_class_code: json["emd_class_code"] ?? '',
        fig: json["fig"] ?? '',
        // phone_no: json["phone_no"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "userid": userid,
        "userpw": userpw,
        "user_name": user_name,
        "user_email": user_email,
        "user_type": user_type,
        "youthAge_code": youthAge_code,
        "parentsAge_code": parentsAge_code,
        "sex_class_code": sex_class_code,
        "emd_class_code": emd_class_code,
        "fig": fig,
        // "phone_no" : phone_no,
      };
}
