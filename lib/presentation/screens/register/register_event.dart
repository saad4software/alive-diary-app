part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {

  final String? email;
  final String? password;
  final String? confirm;
  final String? firstName;
  final String? lastName;

  const RegisterEvent({
    this.email,
    this.password,
    this.confirm,
    this.firstName,
    this.lastName
  });

}

class RegisterClickedEvent extends RegisterEvent {


  const RegisterClickedEvent({
    super.email,
    super.password,
    super.confirm,
    super.firstName,
    super.lastName,

  });
}
