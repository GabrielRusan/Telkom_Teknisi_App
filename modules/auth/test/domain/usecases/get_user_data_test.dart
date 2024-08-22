import 'package:auth/domain/usecases/get_user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import '../../test_helper/test_helper.mocks.dart';

void main() {
  late MockAuthRepository mockRepo;
  late GetUserData usecase;

  setUp(() {
    mockRepo = MockAuthRepository();
    usecase = GetUserData(repository: mockRepo);
  });

  test('should get valid user data when everything is allright', () async {
    //arrange
    when(mockRepo.getUserData()).thenAnswer((_) async => Right(tUser));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, Right(tUser));
  });
}
