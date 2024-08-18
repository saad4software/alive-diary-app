part of 'temp_bloc.dart';

@immutable
sealed class TempState {
  final List<DiaryModel>? list;
  final String? errorMessage;
  final bool? noMoreData;

  const TempState({this.list, this.errorMessage, this.noMoreData});
}

final class TempInitialState extends TempState {}
final class TempLoadingState extends TempState {
  const TempLoadingState({super.list});
}
final class TempListState extends TempState {
  const TempListState({super.list, super.noMoreData});
}

final class TempErrorState extends TempState {
  TempErrorState({super.errorMessage});
}
