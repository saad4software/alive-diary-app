part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {
  final String? text;
  final int? conversation;

  final DiaryModel? diary;
  final ConversationType? type;

  const ConversationEvent({
    this.text,
    this.conversation,
    this.diary,
    this.type,
  });
}

class ConversationStartEvent extends ConversationEvent {
  const ConversationStartEvent({super.diary, super.type});
}

class ConversationSendEvent extends ConversationEvent {
  const ConversationSendEvent({super.text, super.diary, super.type});
}


class ConversationReadTextEvent extends ConversationEvent {
  const ConversationReadTextEvent({super.text});
}

class ConversationWriteTextEvent extends ConversationEvent {}
