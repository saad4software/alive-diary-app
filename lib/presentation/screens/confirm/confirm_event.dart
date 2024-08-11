part of 'confirm_bloc.dart';

@immutable
sealed class ConfirmEvent {
  final String? email;
  final String? code;

  const ConfirmEvent({this.email, this.code});
}

class ConfirmClickedEvent extends ConfirmEvent {
  const ConfirmClickedEvent({super.email, super.code});
}