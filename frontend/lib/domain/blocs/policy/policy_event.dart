part of 'policy_bloc.dart';

@immutable
abstract class PolicyEvent {}

// 이미지 선택
// class OnSelectedImageEvent extends PolicyEvent {
//   final File imageSelected;
//   OnSelectedImageEvent(this.imageSelected);
// }

// 정책 검색
class OnIsSearchPolicyEvent extends PolicyEvent {
  final bool isSearchPolicy;

  OnIsSearchPolicyEvent(this.isSearchPolicy);
}

// 정책 검색 조건 선택
// class OnIsSelectPolicyEvent extends PolicyEvent {
//   final bool isSelectPolicy;

//   OnIsSelectPolicyEvent(this.isSelectPolicy);
// }

// 정책 스크랩
class OnScrapOrUnscrapPolicy extends PolicyEvent {
  final String uidPolicy;
  final String uidUser;

  OnScrapOrUnscrapPolicy(this.uidPolicy, this.uidUser);
}
