import 'dart:async';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final ApiRepository apiRepository;

  RegisterBloc(this.apiRepository) : super(RegisterInitial()) {
    on<RegisterClickedEvent>(handleRegister);
  }




  FutureOr<void> handleRegister(
      RegisterClickedEvent event,
      Emitter<RegisterState> emit
  ) async {
    emit(RegisterLoadingState());

    final response = await apiRepository.register(
        firstName: event.firstName ?? "",
        lastName: event.lastName ?? "",
        username: event.email ?? "",
        password1: event.password ?? "",
        password2: event.confirm ?? "",
    );

    if (response is DataSuccess) {
      emit(RegisterSuccessState());

    } else if (response is DataFailed) {
      emit(RegisterErrorState(error: response.error));
    }

  }
}
