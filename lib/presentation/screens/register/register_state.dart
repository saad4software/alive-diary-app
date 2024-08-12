part of 'register_bloc.dart';

@immutable
sealed class RegisterState {
  final DioException? error;
  final UserModel? user;

  const RegisterState({this.error, this.user});
}

final class RegisterInitial extends RegisterState {}
final class RegisterLoadingState extends RegisterState {}
final class RegisterSuccessState extends RegisterState {
  const RegisterSuccessState({super.user});
}
final class RegisterErrorState extends RegisterState {
  const RegisterErrorState({super.error});
}
