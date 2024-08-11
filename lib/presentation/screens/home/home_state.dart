part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final DioException? error;
  final String? errorMessage;
  final String? text;
  final int? conversation;
  final DiaryModel? memory;

  const HomeState({
    this.error,
    this.errorMessage,
    this.text,
    this.conversation,
    this.memory,
  });

}

final class HomeInitialState extends HomeState {}
final class HomeLoadingState extends HomeState {}
final class HomeListeningState extends HomeState {}
final class HomeStartState extends HomeState {}

final class HomeSuccessState extends HomeState {
  const HomeSuccessState({super.text});
}

final class HomeWriteTextState extends HomeState {
  const HomeWriteTextState({super.text});
}

final class HomeCreatedMemoryState extends HomeState {
  const HomeCreatedMemoryState({super.memory});
}

final class HomeErrorState extends HomeState {
  const HomeErrorState({super.errorMessage});
}
