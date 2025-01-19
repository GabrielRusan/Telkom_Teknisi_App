part of 'edit_foto_profile_bloc.dart';

@immutable
sealed class EditFotoProfileState {}

final class EditFotoProfileInitial extends EditFotoProfileState {}

final class EditFotoProfileFailed extends EditFotoProfileState {}

final class EditFotoProfileLoading extends EditFotoProfileState {}

final class EditFotoProfileSuccess extends EditFotoProfileState {}
