part of 'library_bloc.dart';

@immutable
sealed class LibraryState {
  final DioException? error;
  final String? errorMessage;
  final List<DiaryModel> diariesList;
  final List<DiaryModel> memoriesList;
  final bool noMoreDiaries;
  final bool noMoreMemories;

  const LibraryState({
    this.error,
    this.errorMessage,
    this.diariesList = const [],
    this.memoriesList = const [],
    this.noMoreDiaries = true,
    this.noMoreMemories = true,
  });



}

final class LibraryInitial extends LibraryState {}
final class LibraryLoadingState extends LibraryState {}
final class LibraryDiariesState extends LibraryState {
  const LibraryDiariesState({super.diariesList, super.noMoreDiaries});
}
final class LibraryMemoriesState extends LibraryState {
  const LibraryMemoriesState({super.memoriesList, super.noMoreMemories});
}
final class LibraryErrorState extends LibraryState {
  const LibraryErrorState({super.errorMessage});
}
