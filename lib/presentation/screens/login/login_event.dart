part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  final String username;
  final String password;



  const LoginEvent({
    this.username = "",
    this.password = ""
  });

}

class LoginInitEvent extends LoginEvent {}

class LoginPressedEvent extends LoginEvent{
  const LoginPressedEvent({super.username, super.password});
}
