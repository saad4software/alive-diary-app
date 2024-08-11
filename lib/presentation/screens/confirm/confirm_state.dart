part of 'confirm_bloc.dart';

@immutable
sealed class ConfirmState {
  final DioException? error;

  const ConfirmState({this.error});

}

final class ConfirmInitial extends ConfirmState {}

final class ConfirmLoadingState extends ConfirmState {}
final class ConfirmSuccessState extends ConfirmState {}
final class ConfirmErrorState extends ConfirmState {
  const ConfirmErrorState({super.error});
}
