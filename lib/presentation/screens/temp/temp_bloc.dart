import 'dart:async';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/config/extension/dio_exception_extension.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/models/entities/memory_model.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'temp_event.dart';
part 'temp_state.dart';

class TempBloc extends Bloc<TempEvent, TempState> {

  final ApiRepository repository;

  int page= 1;
  List<MemoryModel> list = [];
  bool noMore = false;

  TempBloc(this.repository) : super(TempInitialState()) {
    on<TempListEvent>(handleTempList);
    on<TempRefreshEvent>(handleRefreshList);
  }

  FutureOr<void> handleTempList(
      TempListEvent event,
      Emitter<TempState> emit,
  ) async {

    if (noMore) return;

    emit(TempLoadingState(list: list));

    final response = await repository.memoriesList(page: page);

    if (response is DataSuccess) {
      noMore = response.data?.data?.next == null;

      list.addAll(response.data?.data?.results ?? []);
      page ++;

      emit(TempListState(
          list: list,
          noMoreData: noMore,
      ));

    } else if (response is DataFailed) {
      emit(TempErrorState(errorMessage: response.error?.getErrorMessage()));
    }


  }

  FutureOr<void> handleRefreshList(
      TempRefreshEvent event,
      Emitter<TempState> emit,
  ) async {
    page = 1;
    list.clear();
    noMore = false;
    add(TempListEvent());
  }
}
