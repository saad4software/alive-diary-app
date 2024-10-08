import 'dart:async';
import 'dart:io';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/config/extension/dio_exception_extension.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/models/entities/memory_model.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {

  final ApiRepository apiRepository;
  // int diariesPage = 1;
  // int memoriesPage = 1;

  // bool noMoreDiaries = false;
  // bool noMoreMemories = false;

  // List<DiaryModel> diariesList = [];
  // List<DiaryModel> memoriesList = [];

  LibraryBloc(this.apiRepository) : super(LibraryInitial()) {
    // on<LibraryDiariesListEvent>(handleDiariesList);
    // on<LibraryMemoriesListEvent>(handleMemoriesList);
    on<LibraryShareDiaryEvent>(handleShareDiary);
    on<LibraryShareMemoryEvent>(handleShareMemory);
    on<LibraryDelDiaryEvent>(handleDeleteDiary);
    on<LibraryDelMemoryEvent>(handleDeleteMemory);
  }

  // FutureOr<void> handleDiariesList(
  //     LibraryDiariesListEvent event,
  //     Emitter<LibraryState> emit
  // ) async {
  //
  //   emit(LibraryLoadingState());
  //
  //   final response = await apiRepository.diariesList(page: diariesPage);
  //   if (response is DataSuccess) {
  //
  //     final list = response.data?.data?.results ?? [];
  //     if (list.isNotEmpty && !diariesList.contains(list.first)) diariesList.addAll(list);
  //
  //     emit(LibraryDiariesState(
  //       diariesList: diariesList,
  //       noMoreDiaries: response.data?.data?.next == null,
  //     ));
  //
  //   } else if (response is DataFailed) {
  //     emit(LibraryErrorState(errorMessage: response.error?.getErrorMessage()));
  //   }
  //
  // }

  // FutureOr<void> handleMemoriesList(
  //     LibraryMemoriesListEvent event,
  //     Emitter<LibraryState> emit
  // ) async {
  //
  //   emit(LibraryLoadingState());
  //
  //   final response = await apiRepository.memoriesList(page: memoriesPage);
  //   if (response is DataSuccess) {
  //
  //     final list = response.data?.data?.results ?? [];
  //     if (list.isNotEmpty && !memoriesList.contains(list.first)) memoriesList.addAll(list);
  //
  //
  //     emit(LibraryMemoriesState(
  //       memoriesList: memoriesList,
  //       noMoreMemories: response.data?.data?.next == null,
  //     ));
  //
  //   } else if (response is DataFailed) {
  //     emit(LibraryErrorState(errorMessage: response.error?.getErrorMessage()));
  //   }
  //
  // }

  FutureOr<void> handleShareDiary(
      LibraryShareDiaryEvent event,
      Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoadingState());

    final response = await apiRepository.diaryShare(item: event.diary!, email: event.email ?? "");
    if (response is DataSuccess) {
      emit(LibraryShareDiaryState());
    } else if (response is DataFailed) {
      emit(LibraryErrorState(errorMessage: response.error?.getErrorMessage()));
    }

  }

  FutureOr<void> handleShareMemory(
      LibraryShareMemoryEvent event,
      Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoadingState());

    final response = await apiRepository.memoryShare(item: event.memory!, email: event.email ?? "");
    if (response is DataSuccess) {
      emit(LibraryShareMemoryState());
    } else if (response is DataFailed) {
      emit(LibraryErrorState(errorMessage: response.error?.getErrorMessage()));
    }

  }

  FutureOr<void> handleDeleteDiary(
      LibraryDelDiaryEvent event,
      Emitter<LibraryState> emit,
  ) async {

    final response = await apiRepository.diariesDelete(item: event.diary!);
    if (response is DataSuccess) {
      emit(LibraryDeleteDiaryState());
    } else if (response is DataFailed) {
      emit(LibraryErrorState(errorMessage: response.error?.getErrorMessage()));
    }


  }

  FutureOr<void> handleDeleteMemory(
      LibraryDelMemoryEvent event,
      Emitter<LibraryState> emit,
  ) async {

    final response = await apiRepository.memoryDelete(item: event.memory!);
    if (response is DataSuccess) {
      emit(LibraryDeleteMemoryState());
    } else if (response is DataFailed) {
      emit(LibraryErrorState(errorMessage: response.error?.getErrorMessage()));
    }

  }
}
