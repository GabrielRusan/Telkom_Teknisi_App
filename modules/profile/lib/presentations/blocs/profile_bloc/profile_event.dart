part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfileData extends ProfileEvent {}

class SignOut extends ProfileEvent {}
