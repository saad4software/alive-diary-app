part of 'conversation_bloc.dart';

@immutable
sealed class ConversationState {
  final DioException? error;
  final String? errorMessage;
  final String? text;
  final int? conversation;

  const ConversationState({
    this.error,
    this.errorMessage,
    this.text,
    this.conversation,
  });
}

final class ConversationInitial extends ConversationState {}
final class ConversationLoadingState extends ConversationState {}
final class ConversationListeningState extends ConversationState {}
final class ConversationStartState extends ConversationState {}
final class ConversationSuccessState extends ConversationState {
  const ConversationSuccessState({super.text, super.conversation});
}
final class ConversationWriteTextState extends ConversationState {
  const ConversationWriteTextState({super.text});
}
final class ConversationErrorState extends ConversationState {
  const ConversationErrorState({super.errorMessage});
}
