import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teentalktalk/domain/services/policy_services.dart';
part 'policy_event.dart';
part 'policy_state.dart';

class PolicyBloc extends Bloc<PolicyEvent, PolicyState> {
  // List<File> listImages = [];

  PolicyBloc() : super(const PolicyState()) {
    // on<OnSelectedImageEvent>(_onSelectedImage);
    on<OnIsSearchPolicyEvent>(_isSearchPolicy);
    // on<OnIsSearchPolicyEvent>(_isSelectPolicy);
    on<OnScrapOrUnscrapPolicy>(_scrapOrUnscrapPolicy);
  }

  // Future<void> _onSelectedImage(
  //     OnSelectedImageEvent event, Emitter<PolicyState> emit) async {
  //   listImages.add(event.imageSelected);
  //   emit(state.copyWith(imageSelected: listImages, isSearchPolicy: false));
  // }

  Future<void> _isSearchPolicy(
      OnIsSearchPolicyEvent event, Emitter<PolicyState> emit) async {
    emit(state.copyWith(isSearchPolicy: event.isSearchPolicy));
  }

  // Future<void> _isSelectPolicy(
  //     OnIsSelectPolicyEvent event, Emitter<PolicyState> emit) async {
  //   emit(state.copyWith(
  //       isSearchPolicy: false, isSelectPolicy: event.isSelectPolicy));
  // }

  Future<void> _scrapOrUnscrapPolicy(
      OnScrapOrUnscrapPolicy event, Emitter<PolicyState> emit) async {
    print('_scrapOrUnscrapPolicy');
    try {
      emit(LoadingPolicy());
      // print('after Loading Policy');

      final data = await policyService.scrapOrUnscrapPolicy(
          event.uidPolicy, event.uidUser);
      // print('scrap :');
      // print(data);

      if (data.resp) {
        emit(SuccessPolicyScrap());
      } else {
        emit(FailurePolicy(data.message));
      }
    } catch (e) {
      emit(FailurePolicy(e.toString()));
    }
  }
}
