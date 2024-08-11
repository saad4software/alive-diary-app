part of 'profile_edit_bloc.dart';

@immutable
sealed class ProfileEditState {}

final class ProfileEditInitial extends ProfileEditState {}
final class ProfileEditLoadingState extends ProfileEditState {}
final class ProfileEditSuccessState extends ProfileEditState {}
