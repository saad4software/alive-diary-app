part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent {
  final int? page;
  final int? pageSize;

  const LibraryEvent({this.page, this.pageSize});
}

class LibraryDiariesListEvent extends LibraryEvent {
  const LibraryDiariesListEvent({super.page});
}

class LibraryMemoriesListEvent extends LibraryEvent {
  const LibraryMemoriesListEvent({super.page});
}
