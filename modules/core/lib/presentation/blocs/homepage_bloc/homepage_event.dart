part of 'homepage_bloc.dart';

sealed class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class OnChanedIndex extends HomepageEvent {
  final int index;

  const OnChanedIndex({required this.index});
  @override
  List<Object> get props => [index];
}
