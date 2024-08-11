part of 'login_bloc.dart';

@immutable
sealed class LoginState {
  final String? errorMessage;
  final bool isLoggedIn;

  const LoginState({
    this.errorMessage,
    this.isLoggedIn = false
  });

}

final class LoginInitialState extends LoginState {
  const LoginInitialState({super.isLoggedIn});
}

final class LoginLoadingState extends LoginState {}
final class LoginSuccessState extends LoginState {}
final class LoginErrorState extends LoginState {
  const LoginErrorState({super.errorMessage});
}
