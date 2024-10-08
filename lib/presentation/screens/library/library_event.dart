part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent {
  final int? page;
  final int? pageSize;
  final String? email;
  final DiaryModel? diary;
  final MemoryModel? memory;

  const LibraryEvent({
    this.page,
    this.pageSize,
    this.email,
    this.diary,
    this.memory,
  });
}

class LibraryDiariesListEvent extends LibraryEvent {
  const LibraryDiariesListEvent({super.page});
}

class LibraryMemoriesListEvent extends LibraryEvent {
  const LibraryMemoriesListEvent({super.page});
}

class LibraryShareDiaryEvent extends LibraryEvent {
  const LibraryShareDiaryEvent({super.email, super.diary});
}

class LibraryShareMemoryEvent extends LibraryEvent {
  const LibraryShareMemoryEvent({
    super.email,
    super.memory,
  });
}

class LibraryDelMemoryEvent extends LibraryEvent {
  const LibraryDelMemoryEvent({super.memory});
}

class LibraryDelDiaryEvent extends LibraryEvent {
  const LibraryDelDiaryEvent({super.diary});
}
