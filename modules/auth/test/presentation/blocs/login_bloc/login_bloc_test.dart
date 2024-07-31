import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:auth/utils/login_status.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_helper/usecase_test_helper.mocks.dart';

void main() {
  late MockLogin mockLogin;
  late LoginBloc loginBloc;

  setUp(() {
    mockLogin = MockLogin();
    loginBloc = LoginBloc(mockLogin);
  });

  const String tUsername = 'username';
  const String tPassword = 'password';

  test('Initial state should be LoginInitial', () {
    expect(loginBloc.state.loginStatus, LoginStatus.initial);
  });

  group('on Username Changed', () {
    blocTest<LoginBloc, LoginState>(
      'emit [username] when event occured',
      build: () {
        return loginBloc;
      },
      act: (bloc) => bloc.add(const UsernameChanged(value: tUsername)),
      expect: () => [
        const LoginState(
          username: tUsername,
        ),
      ],
    );
  });

  group('on Password Changed', () {
    blocTest<LoginBloc, LoginState>(
      'emit [password] when event occured',
      build: () {
        return loginBloc;
      },
      act: (bloc) => bloc.add(const UsernameChanged(value: tPassword)),
      expect: () => [
        const LoginState(
          username: tPassword,
        ),
      ],
    );
  });

  group("On Sign In", () {
    blocTest<LoginBloc, LoginState>(
      'Should emit [inProgrees, Success] when SignIn is Successful',
      build: () {
        when(mockLogin.execute(username: tUsername, password: tPassword))
            .thenAnswer((_) async => const Right(true));
        return loginBloc;
      },
      act: (bloc) => bloc.add(SignIn()),
      seed: () => const LoginState(
        username: tUsername,
        password: tPassword,
        loginStatus: LoginStatus.initial,
      ),
      expect: () => [
        const LoginState(
          username: tUsername,
          password: tPassword,
          loginStatus: LoginStatus.inProggres,
        ),
        const LoginState(
          username: tUsername,
          password: tPassword,
          loginStatus: LoginStatus.success,
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'Should emit [inProgrees, Failed] with right message when SignIn is not Successful due to LoginFailure',
      build: () {
        when(mockLogin.execute(username: tUsername, password: tPassword))
            .thenAnswer(
                (_) async => const Left(LoginFailure('Wrong Password!')));
        return loginBloc;
      },
      act: (bloc) => bloc.add(SignIn()),
      seed: () => const LoginState(
        username: tUsername,
        password: tPassword,
        loginStatus: LoginStatus.initial,
      ),
      expect: () => [
        const LoginState(
          username: tUsername,
          password: tPassword,
          loginStatus: LoginStatus.inProggres,
        ),
        const LoginState(
          username: tUsername,
          password: tPassword,
          loginStatus: LoginStatus.failed,
          errorMessage: 'Wrong Password!',
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'Should emit [inProgrees, Failed] with right message when SignIn is not Successful due to Server Error',
      build: () {
        when(mockLogin.execute(username: tUsername, password: tPassword))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Error!')));
        return loginBloc;
      },
      act: (bloc) => bloc.add(SignIn()),
      seed: () => const LoginState(
        username: tUsername,
        password: tPassword,
        loginStatus: LoginStatus.initial,
      ),
      expect: () => [
        const LoginState(
          username: tUsername,
          password: tPassword,
          loginStatus: LoginStatus.inProggres,
        ),
        const LoginState(
          username: tUsername,
          password: tPassword,
          loginStatus: LoginStatus.failed,
          errorMessage: 'Server Error!',
        ),
      ],
    );
  });
}
