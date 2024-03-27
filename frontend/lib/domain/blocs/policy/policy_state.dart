part of 'policy_bloc.dart';

@immutable
class PolicyState {
  // final List<File>? imageFileSelected;
  final bool isSearchPolicy;
  // final bool isSelectPolicy;
  // final int scrapNumber;

  const PolicyState({
    // this.imageFileSelected,
    this.isSearchPolicy = false,
    // this.isSelectPolicy = true,
    // this.scrapNumber = 0,
  });

  PolicyState copyWith({
    // List<File>? imageSelected,
    // int? scrapnumber,
    required bool isSearchPolicy,
    // required bool isSelectPolicy
  }) =>
      PolicyState(
        // imageFileSelected: imageFileSelected ?? imageFileSelected,
        isSearchPolicy: isSearchPolicy, //?? this.isSearchPolicy,
        // isSelectPolicy: isSelectPolicy //?? this.isSelectPolicy
        // scrapNumber: scrapNumber // ?? this.scrapNumber,
      );
}

class LoadingPolicy extends PolicyState {}

class FailurePolicy extends PolicyState {
  final String error;

  const FailurePolicy(this.error);
}

class SuccessPolicyScrap extends PolicyState {}
