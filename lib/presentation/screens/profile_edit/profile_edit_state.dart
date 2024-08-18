part of 'profile_edit_bloc.dart';

@immutable
sealed class ProfileEditState {
  final String? errorMessage;

  const ProfileEditState({this.errorMessage});
}

final class ProfileEditInitial extends ProfileEditState {}
final class ProfileEditLoadingState extends ProfileEditState {}
final class ProfileEditSuccessState extends ProfileEditState {}
final class ProfileEditErrorState extends ProfileEditState {
  const ProfileEditErrorState({super.errorMessage});
}
