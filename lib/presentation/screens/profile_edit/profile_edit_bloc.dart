import 'dart:async';
import 'dart:convert';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/config/constants/app_consts.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alive_diary/config/extension/dio_exception_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {

  final ApiRepository apiRepository;
  final SharedPreferences preferences;


  ProfileEditBloc(this.apiRepository, this.preferences) : super(ProfileEditInitial()) {
    on<ProfileEditUpdateEvent>(handleUpdateEvent);
  }

  FutureOr<void> handleUpdateEvent(
      ProfileEditUpdateEvent event,
      Emitter<ProfileEditState> emit
  ) async {
    emit(ProfileEditLoadingState());

    final response = await apiRepository.updateProfile(UserModel(
      firstName: event.firstName,
      lastName: event.lastName,
      bio: event.bio,
    ));

    if (response is DataSuccess) {

      preferences.setString(
        AppConsts.keyUser,
        jsonEncode(response.data?.data),
      );


      emit(ProfileEditSuccessState());
    } else if (response is DataFailed) {

      emit(ProfileEditErrorState(errorMessage: response.error?.getErrorMessage()));
    }

  }
}
