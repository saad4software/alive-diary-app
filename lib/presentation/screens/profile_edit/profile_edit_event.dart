part of 'profile_edit_bloc.dart';

@immutable
sealed class ProfileEditEvent {
  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? hobbies;

  const ProfileEditEvent({this.firstName, this.lastName, this.bio, this.hobbies});
}

class ProfileEditUpdateEvent extends ProfileEditEvent {
  const ProfileEditUpdateEvent({super.firstName, super.lastName, super.bio, super.hobbies});

}
