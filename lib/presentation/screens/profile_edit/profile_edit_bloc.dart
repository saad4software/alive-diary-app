import 'dart:async';

import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {

  final ApiRepository apiRepository;

  ProfileEditBloc(this.apiRepository) : super(ProfileEditInitial()) {
    on<ProfileEditUpdateEvent>(handleUpdateEvent);
  }

  FutureOr<void> handleUpdateEvent(
      ProfileEditUpdateEvent event,
      Emitter<ProfileEditState> emit
  ) async {
    emit(ProfileEditLoadingState());

    // final response = await apiRepository.
  }
}
