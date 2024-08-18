part of 'list_bloc.dart';

@immutable
sealed class ListState<T> {
  final List<T>? list;
  final String? errorMessage;
  final bool? noMoreData;

  const ListState({this.list, this.errorMessage, this.noMoreData});
}

final class ListInitialState<T> extends ListState<T> {}

final class ListLoadingState<T> extends ListState<T> {
  const ListLoadingState({super.list});
}
final class ListSuccessState<T> extends ListState<T> {
  const ListSuccessState({super.list, super.noMoreData});
}

final class ListErrorState<T> extends ListState<T> {
  const ListErrorState({super.errorMessage});
}
