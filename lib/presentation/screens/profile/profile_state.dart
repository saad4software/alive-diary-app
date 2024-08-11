part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {
  final UserModel? user;

  const ProfileState({this.user});
}

final class ProfileInitial extends ProfileState {}

final class ProfileSuccessState extends ProfileState {
  const ProfileSuccessState({super.user});
}

