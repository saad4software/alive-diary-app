import 'dart:async';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'confirm_event.dart';
part 'confirm_state.dart';

class ConfirmBloc extends Bloc<ConfirmEvent, ConfirmState> {

  final ApiRepository apiRepository;

  ConfirmBloc(this.apiRepository) : super(ConfirmInitial()) {
    on<ConfirmClickedEvent>(handleConfirmClicked);
  }

  FutureOr<void> handleConfirmClicked(ConfirmClickedEvent event, Emitter<ConfirmState> emit) async {
    emit(ConfirmLoadingState());

    final response = await apiRepository.activate(
        username: event.email ?? "",
        code: event.code ?? "",
    );

    if (response is DataSuccess) {
      emit(ConfirmSuccessState());
    } else if (response is DataFailed) {
      emit(ConfirmErrorState(error: response.error));
    }


  }
}
