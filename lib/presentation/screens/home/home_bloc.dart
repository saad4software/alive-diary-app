import 'dart:async';
import 'dart:convert';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/config/constants/app_consts.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:alive_diary/config/extension/dio_exception_extension.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final ApiRepository apiRepository;
  final  FlutterLocalization localization;
  final FlutterTts tts;
  final SpeechToText stt;
  final SharedPreferences preferences;

  int? conversationId;
  String? recognizedText = "";


  HomeBloc(
      this.apiRepository,
      this.localization,
      this.tts,
      this.stt,
      this.preferences,
  ) : super(HomeInitialState()) {

    on<HomeStartEvent> (handleStartEvent);
    on<HomeSendEvent> (handleSendEvent);
    on<HomeReadTextEvent> (handleReadText);
    on<HomeWriteTextEvent> (handleWriteText);
    on<HomeCreateMemoryEvent> (handleCreateMemory);

  }

  FutureOr<void> handleStartEvent(
      HomeStartEvent event,
      Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    final diaryString = preferences.getString(AppConsts.keyMyDiary);
    final diary = DiaryModel.fromJson(jsonDecode(diaryString!));


    final response = await apiRepository.diaryCreateStart(item: diary);

    if (response is DataSuccess) {
      conversationId = response.data?.data?.conversation;

      emit(HomeSuccessState(
        text: response.data?.data?.text,
      ));
    } else {

      emit(HomeErrorState(errorMessage: response.error?.getErrorMessage(),));
    }


  }

  FutureOr<void> handleSendEvent(
      HomeSendEvent event,
      Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    recognizedText = "";

    final diaryString = preferences.getString(AppConsts.keyMyDiary);
    final diary = DiaryModel.fromJson(jsonDecode(diaryString!));

    final response = await apiRepository.diaryCreateSend(
      item: diary,
      text: event.text ?? "",
      conversation: conversationId ?? 0,
    );

    if (response is DataSuccess) {
      emit(HomeSuccessState(
        text: response.data?.data?.text,
      ));

    } else if (response is DataFailed) {
      emit(HomeErrorState(
          errorMessage: response.error?.getErrorMessage(),
      ));
    }


  }

  FutureOr<void> handleReadText(
      HomeReadTextEvent event,
      Emitter<HomeState> emit
  ) async {

    emit(HomeLoadingState());

    await tts.setLanguage(localization.currentLocale.localeIdentifier);
    await tts.setSpeechRate(0.5);
    await tts.setVolume(1.0);
    await tts.setPitch(1.0);

    // wait for text to start showing on the screen
    await Future.delayed(const Duration(seconds: 1));

    await tts.speak(event.text ?? "");

    emit(HomeInitialState());

  }

  FutureOr<void> handleWriteText(
      HomeWriteTextEvent event,
      Emitter<HomeState> emit
  ) async {
    emit(HomeListeningState());

    bool available = await stt.initialize();

    if (available) {
      await listen();
      emit(HomeWriteTextState(text: recognizedText));

    } else {
      emit(const HomeErrorState(
        errorMessage: "Speech recognition permission denied",
      ));
    }

  }

  // convert listen callback to Future
  Future listen() async {

    Completer c = Completer();

    stt.listen(
        onResult: (result) {
          recognizedText = "${recognizedText?.trim()} ${result.recognizedWords}";
          c.complete(recognizedText);
        },
        listenFor: const Duration(minutes: 2),
        localeId: localization.currentLocale.localeIdentifier,
        listenOptions: SpeechListenOptions(
          partialResults: false,
        )
    );

    return c.future;
  }

  FutureOr<void> handleCreateMemory(
      HomeCreateMemoryEvent event,
      Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    final response = await apiRepository.memoryCreate(name: event.memoryName ?? "memory");

    if (response is DataSuccess) {
      emit(HomeCreatedMemoryState(
        memory: response.data?.data,
      ));

    } else if (response is DataFailed) {
      emit(HomeErrorState(
        errorMessage: response.error?.getErrorMessage(),
      ));
    }

  }
}
