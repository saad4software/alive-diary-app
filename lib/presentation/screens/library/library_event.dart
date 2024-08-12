part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent {
  final int? page;
  final int? pageSize;
  final String? email;
  final DiaryModel? item;

  const LibraryEvent({
    this.page,
    this.pageSize,
    this.email,
    this.item,
  });
}

class LibraryDiariesListEvent extends LibraryEvent {
  const LibraryDiariesListEvent({super.page});
}

class LibraryMemoriesListEvent extends LibraryEvent {
  const LibraryMemoriesListEvent({super.page});
}

class LibraryShareDiaryEvent extends LibraryEvent {
  const LibraryShareDiaryEvent({super.email, super.item});
}

class LibraryShareMemoryEvent extends LibraryEvent {
  const LibraryShareMemoryEvent({
    super.email,
    super.item,
  });
}

class LibraryDelMemoryEvent extends LibraryEvent {
  const LibraryDelMemoryEvent({super.item});
}

class LibraryDelDiaryEvent extends LibraryEvent {
  const LibraryDelDiaryEvent({super.item});
}
