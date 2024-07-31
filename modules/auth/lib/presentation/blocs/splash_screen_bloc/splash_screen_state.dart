part of 'splash_screen_bloc.dart';

sealed class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

final class SplashScreenInitial extends SplashScreenState {}

final class SplashScreenLoading extends SplashScreenState {}

final class SplashScreenFailed extends SplashScreenState {}

final class SplashScreenSuccess extends SplashScreenState {}
