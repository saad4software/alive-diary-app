part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  final String? text;
  final int? conversation;
  final String? memoryName;

  const HomeEvent({
    this.text,
    this.conversation,
    this.memoryName,
  });
}


class HomeStartEvent extends HomeEvent {}


class HomeSendEvent extends HomeEvent {
  const HomeSendEvent({super.text, super.conversation});
}

class HomeReadTextEvent extends HomeEvent {
  const HomeReadTextEvent({super.text});
}

class HomeWriteTextEvent extends HomeEvent {}
class HomeCreateMemoryEvent extends HomeEvent {
  const HomeCreateMemoryEvent({super.memoryName});
}
