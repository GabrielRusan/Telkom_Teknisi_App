import 'package:auth/domain/entities/user.dart';
import 'package:auth/domain/usecases/get_user_data.dart';
import 'package:auth/domain/usecases/logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserData getUserData;
  final Logout logout;
  ProfileBloc(this.getUserData, this.logout) : super(ProfileInitial()) {
    on<FetchUserProfileData>((event, emit) async {
      emit(ProfileLoading());

      final result = await getUserData.execute();

      result.fold((failure) {
        emit(ProfileFailed());
      }, (data) {
        emit(ProfileSuccess(user: data));
      });
    });

    on<SignOut>(
      (event, emit) async {
        await logout.execute();
      },
    );
  }
}
