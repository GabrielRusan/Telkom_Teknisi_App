part of 'homepage_bloc.dart';

final class HomepageState extends Equatable {
  final int index;
  const HomepageState({this.index = 0});

  @override
  List<Object> get props => [index];
}
