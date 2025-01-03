import 'package:auth/domain/usecases/get_notif_permission.dart';
import 'package:auth/domain/usecases/login.dart';
import 'package:auth/utils/login_status.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/transformers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login usecase;
  final GetNotifPermission usecase2;
  LoginBloc(this.usecase, this.usecase2) : super(const LoginState()) {
    on<SignIn>(_onSignIn,
        transformer: throttleDroppable(const Duration(seconds: 1)));
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ClearValue>(
      (event, emit) => emit(const LoginState()),
    );
    on<RequestNotifPermission>((event, emit) async => usecase2.execute());
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        username: event.value, loginStatus: LoginStatus.initial));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        password: event.value, loginStatus: LoginStatus.initial));
  }

  Future<void> _onSignIn(SignIn event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.inProggres));

    final result = await usecase.execute(
      username: state.username,
      password: state.password,
    );

    result.fold((failure) {
      if (failure is NotifPermitFailure) {
        emit(state.copyWith(
            loginStatus: LoginStatus.noPermit, errorMessage: failure.message));
      } else {
        emit(state.copyWith(
            loginStatus: LoginStatus.failed, errorMessage: failure.message));
      }
    }, (status) {
      emit(state.copyWith(loginStatus: LoginStatus.success));
    });
  }
}
