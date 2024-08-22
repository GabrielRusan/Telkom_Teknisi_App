part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileFailed extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final User user;

  const ProfileSuccess({required this.user});

  @override
  List<Object> get props => [user];
}
