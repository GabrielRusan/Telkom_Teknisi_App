import 'package:auth/presentation/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../test_helper/usecase_test_helper.mocks.dart';

void main() {
  late MockGetUserData mockGetUserData;
  late SplashScreenBloc splashScreenBloc;

  setUp(() {
    mockGetUserData = MockGetUserData();
    splashScreenBloc = SplashScreenBloc(mockGetUserData);
  });

  test('Initial state should be SplashScreenInitial', () {
    expect(splashScreenBloc.state, SplashScreenInitial());
  });

  blocTest<SplashScreenBloc, SplashScreenState>(
    'Should emit [Loading, Success] when Fetch data is Successful',
    build: () {
      when(mockGetUserData.execute()).thenAnswer((_) async => Right(tUser));
      return splashScreenBloc;
    },
    act: (bloc) => bloc.add(FetchUserData()),
    expect: () => [
      SplashScreenLoading(),
      SplashScreenSuccess(),
    ],
  );

  blocTest<SplashScreenBloc, SplashScreenState>(
    'Should emit [Loading, Failed] when getting NoCredentialFailure',
    build: () {
      when(mockGetUserData.execute())
          .thenAnswer((_) async => const Left(NoCredentialFailure('')));
      return splashScreenBloc;
    },
    act: (bloc) => bloc.add(FetchUserData()),
    expect: () => [
      SplashScreenLoading(),
      SplashScreenFailed(),
    ],
  );

  blocTest<SplashScreenBloc, SplashScreenState>(
    'Should emit [Loading, Failed] when getting TokenFailure',
    build: () {
      when(mockGetUserData.execute())
          .thenAnswer((_) async => const Left(TokenFailure('')));
      return splashScreenBloc;
    },
    act: (bloc) => bloc.add(FetchUserData()),
    expect: () => [
      SplashScreenLoading(),
      SplashScreenFailed(),
    ],
  );
  blocTest<SplashScreenBloc, SplashScreenState>(
    'Should emit [Loading, Failed] when getting ServerFailure',
    build: () {
      when(mockGetUserData.execute())
          .thenAnswer((_) async => const Left(ServerFailure('')));
      return splashScreenBloc;
    },
    act: (bloc) => bloc.add(FetchUserData()),
    expect: () => [
      SplashScreenLoading(),
      SplashScreenFailed(),
    ],
  );
}
