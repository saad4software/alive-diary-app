import 'dart:async';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/domain/models/responses/ListResponse.dart';
import 'package:alive_diary/domain/models/responses/generic_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alive_diary/config/extension/dio_exception_extension.dart';
import 'package:flutter/foundation.dart';

// generic list bloc

part 'list_event.dart';
part 'list_state.dart';

typedef BuildFuture<T> = Future<DataState<GenericResponse<ListResponse<T>>>> Function(int page);

class ListBloc<T> extends Bloc<ListEvent, ListState<T>> {

  int page= 1;
  List<T> list = [];
  bool noMore = false;


  final BuildFuture<T> request;

  ListBloc(this.request) : super(ListInitialState<T>()) {
    on<ListGetEvent>(handleGetEvent);
    on<ListRefreshEvent>(handleRefreshEvent);
  }

  FutureOr<void> handleGetEvent(
      ListGetEvent event,
      Emitter<ListState<T>> emit,
  ) async {
    if (noMore) return;
    emit(ListLoadingState<T>(list: list));

    final response = await request(page);
    if (response is DataSuccess) {
      noMore = response.data?.data?.next == null;

      list.addAll(response.data?.data?.results ?? []);
      page ++;

      emit(ListSuccessState<T>(
        list: list,
        noMoreData: noMore,
      ));

    } else if (response is DataFailed) {
      emit(ListErrorState(errorMessage: response.error?.getErrorMessage()));
    }

  }

  FutureOr<void> handleRefreshEvent(
      ListRefreshEvent event,
      Emitter<ListState<T>> emit,
  ) async {

    page = 1;
    list.clear();
    noMore = false;
    add(ListGetEvent());

  }
}
