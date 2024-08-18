import 'dart:async';
import 'dart:convert';

import 'package:alive_diary/config/constants/app_consts.dart';
import 'package:alive_diary/config/di/locator.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{

  final SharedPreferences preferences;

  ProfileBloc(this.preferences) : super(ProfileInitial()) {
    on<ProfileLoadEvent>(handleLoadEvent);
  }

  FutureOr<void> handleLoadEvent(ProfileLoadEvent event, Emitter<ProfileState> emit) async {
    final userString = preferences.getString(AppConsts.keyUser);
    final userModel = UserModel.fromJson(jsonDecode(userString!));

    emit(ProfileSuccessState(user: userModel));

  }
}
