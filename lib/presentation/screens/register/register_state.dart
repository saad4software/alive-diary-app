part of 'register_bloc.dart';

@immutable
sealed class RegisterState {
  final DioException? error;

  const RegisterState({this.error});
}

final class RegisterInitial extends RegisterState {}
final class RegisterLoadingState extends RegisterState {}
final class RegisterSuccessState extends RegisterState {}
final class RegisterErrorState extends RegisterState {
  const RegisterErrorState({super.error});
}
