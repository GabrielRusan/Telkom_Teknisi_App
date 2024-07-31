import 'package:auth/domain/usecases/get_user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final GetUserData getUserData;
  SplashScreenBloc(this.getUserData) : super(SplashScreenInitial()) {
    on<FetchUserData>((event, emit) async {
      emit(SplashScreenLoading());

      final result = await getUserData.execute();

      result.fold((failure) {
        emit(SplashScreenFailed());
      }, (data) {
        emit(SplashScreenSuccess());
      });
    });
  }
}
