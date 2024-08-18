part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {
  final String? text;
  final int? conversation;

  final DiaryModel? diary;
  final MemoryModel? memory;
  final ConversationType? type;

  const ConversationEvent({
    this.text,
    this.conversation,
    this.diary,
    this.memory,
    this.type,
  });
}

class ConversationStartEvent extends ConversationEvent {
  const ConversationStartEvent({super.diary, super.memory, super.type});
}

class ConversationSendEvent extends ConversationEvent {
  const ConversationSendEvent({super.text, super.diary, super.memory, super.type});
}


class ConversationReadTextEvent extends ConversationEvent {
  const ConversationReadTextEvent({super.text});
}

class ConversationWriteTextEvent extends ConversationEvent {}
class ConversationUpdateTextEvent extends ConversationEvent {
  const ConversationUpdateTextEvent({super.text});
}
