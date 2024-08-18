import 'dart:async';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/config/extension/dio_exception_extension.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/models/entities/memory_model.dart';
import 'package:alive_diary/domain/models/entities/message_model.dart';
import 'package:alive_diary/domain/models/responses/ErrorResponse.dart';
import 'package:alive_diary/domain/models/responses/generic_response.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:alive_diary/presentation/screens/conversation/conversation_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {

  final ApiRepository apiRepository;
  final  FlutterLocalization localization;
  final FlutterTts tts;
  final SpeechToText stt;

  int? conversationId;
  String? recognizedText = "";

  ConversationBloc(
      this.apiRepository,
      this.localization,
      this.tts,
      this.stt,
  ) : super(ConversationInitial()) {
    on<ConversationStartEvent>(handleConversationStart);
    on<ConversationSendEvent>(handleConversationSend);
    on<ConversationReadTextEvent>(handleReadText);
    on<ConversationWriteTextEvent>(handleWriteText);
    on<ConversationUpdateTextEvent>(handleUpdateText);
  }

  FutureOr<void> handleConversationStart(
      ConversationStartEvent event,
      Emitter<ConversationState> emit,
  ) async {

    emit(ConversationLoadingState());

    recognizedText = "";

    DataState<GenericResponse<MessageModel>>? response;

    switch (event.type) {

      case ConversationType.diary:
        response = await apiRepository.diaryStart(item: event.diary!);
      case ConversationType.memory:
        response = await apiRepository.memoryStart(item: event.memory!);
      case ConversationType.createMemory:
        response = await apiRepository.memoryCreateStart(item: event.memory!);

      case null:
        print("null type");
    }



    if (response is DataSuccess) {
      conversationId = response?.data?.data?.conversation;

      emit(ConversationSuccessState(
        text: response?.data?.data?.text,
        conversation: response?.data?.data?.conversation,
      ));
    } else {

      final msg = response?.error?.response?.data == null ?
      response?.error?.message :
      ErrorResponse
          .fromJson(response?.error?.response?.data)
          .message?.trim();

      emit(ConversationErrorState(
        errorMessage: msg,
      ));
    }


  }

  FutureOr<void> handleConversationSend(
      ConversationSendEvent event,
      Emitter<ConversationState> emit
  ) async {
    emit(ConversationLoadingState());

    recognizedText = "";

    DataState<GenericResponse<MessageModel>>? response;

    switch (event.type) {

      case ConversationType.diary:
        response = await apiRepository.diarySend(
          item: event.diary!,
          text: event.text ?? "",
          conversation: conversationId ?? 0,
        );

      case ConversationType.memory:
        response = await apiRepository.memorySend(
          item: event.memory!,
          text: event.text ?? "",
          conversation: conversationId ?? 0,
        );

      case ConversationType.createMemory:
        response = await apiRepository.memoryCreateSend(
          item: event.memory!,
          text: event.text ?? "",
          conversation: conversationId ?? 0,
        );

      case null:
        print("null type");
    }


    if (response is DataSuccess) {
      emit(ConversationSuccessState(
        text: response?.data?.data?.text,
      ));

    } else if (response is DataFailed) {
      emit(ConversationErrorState(errorMessage: response?.error?.getErrorMessage()));
    }


  }

  FutureOr<void> handleReadText(
      ConversationReadTextEvent event,
      Emitter<ConversationState> emit,
  ) async {

    emit(ConversationLoadingState());

    await tts.setLanguage(localization.currentLocale.localeIdentifier);
    await tts.setSpeechRate(0.5);
    await tts.setVolume(1.0);
    await tts.setPitch(1.0);

    // wait for text to start showing on the screen
    await Future.delayed(const Duration(seconds: 1));

    await tts.speak(event.text ?? "");

    emit(ConversationInitial());

  }

  FutureOr<void> handleWriteText(
      ConversationWriteTextEvent event,
      Emitter<ConversationState> emit,
  ) async {
    emit(ConversationListeningState());

    bool available = await stt.initialize();

    if (available) {
      await listen();
      emit(ConversationWriteTextState(text: recognizedText));

    } else {
      emit(const ConversationErrorState(
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

  FutureOr<void> handleUpdateText(
      ConversationUpdateTextEvent event,
      Emitter<ConversationState> emit,
  ) {
    recognizedText = event.text;
  }
}
