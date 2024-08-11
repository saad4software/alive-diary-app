import 'dart:async';
import 'dart:convert';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/config/constants/app_consts.dart';
import 'package:alive_diary/config/di/locator.dart';
import 'package:alive_diary/config/extension/dio_exception_extension.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final ApiRepository apiRepository;

  LoginBloc(this.apiRepository) : super(const LoginInitialState()) {

    on<LoginPressedEvent>(handleLoginClicked);
    on<LoginInitEvent>(handleInitiation);

  }

  FutureOr<void> handleLoginClicked(
      LoginPressedEvent event,
      Emitter<LoginState> emit
  ) async {
    emit(LoginLoadingState());

    final response = await apiRepository.login(
      username: event.username,
      password: event.password,
    );

    if (response is DataSuccess) {
      final tokenModel = response.data?.data;

      locator<SharedPreferences>().setString(
          AppConsts.keyToken,
          tokenModel?.access ?? "",
      );

      locator<SharedPreferences>().setString(
          AppConsts.keyUser,
          jsonEncode(tokenModel?.user),
      );

      final diaryRes = await apiRepository.diariesCreate();
      final diary = diaryRes.data?.data;
      locator<SharedPreferences>().setString(
        AppConsts.keyMyDiary,
        jsonEncode(diary),
      );


      emit(LoginSuccessState());
    } else if (response is DataFailed) {

      emit(LoginErrorState(errorMessage: response.error?.getErrorMessage()));
    }

  }

  FutureOr<void> handleInitiation(
      LoginInitEvent event,
      Emitter<LoginState> emit
  ) {
    final token = GetIt.instance<SharedPreferences>().getString(
      AppConsts.keyToken,
    );

    bool hasExpired = (token == null || token.isEmpty) || JwtDecoder.isExpired(token);
    emit(LoginInitialState(isLoggedIn: !hasExpired));


  }
}
