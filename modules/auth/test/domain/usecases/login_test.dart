import 'package:auth/domain/usecases/login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test_helper/test_helper.mocks.dart';

void main() {
  late MockAuthRepository mockRepo;
  late Login usecase;

  setUp(() {
    mockRepo = MockAuthRepository();
    usecase = Login(repository: mockRepo);
  });

  const String tUsername = "username";
  const String tPassword = "password";

  test('should get true when everything is allright', () async {
    //arrange
    when(mockRepo.logIn(username: tUsername, password: tPassword))
        .thenAnswer((_) async => const Right(true));

    //act
    final result =
        await usecase.execute(username: tUsername, password: tPassword);

    //assert
    expect(result, const Right(true));
  });
}
