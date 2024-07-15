import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:via_cep_contacts_projects_uex/shared/data/data.dart';
import 'package:via_cep_contacts_projects_uex/shared/domain/domain.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

class MockFetchUsersUsecase extends Mock implements FetchUsersUsecase {}

void main() {
  late MockLocalStorage mockLocalStorage;
  late MockFetchUsersUsecase mockFetchUsersUsecase;
  late LocalSaveUser localSaveUser;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    mockFetchUsersUsecase = MockFetchUsersUsecase();
    localSaveUser = LocalSaveUser(
      localStorage: mockLocalStorage,
      fetchUsersUsecase: mockFetchUsersUsecase,
    );
  });

  group('LocalSaveUser', () {
    const authEntity = AuthEntity(email: 'test@example.com', password: 'password123');
    final usersList = [const AuthEntity(email: 'existing@example.com', password: 'password')];
    final usersMapList = [
      {'email': 'existing@example.com', 'password': 'password'},
      {'email': 'test@example.com', 'password': 'password123'},
    ];

    test('should save user correctly', () async {
      when(() => mockFetchUsersUsecase()).thenAnswer((_) async => usersList);
      when(() => mockLocalStorage.save(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async => usersList);

      await localSaveUser.call(authEntity: authEntity);

      verify(() => mockFetchUsersUsecase()).called(1);
      verify(() => mockLocalStorage.save(
            key: StorageKeys.users,
            value: jsonEncode(usersMapList),
          )).called(1);
    });

    test('should throw ModelError when CacheError occurs', () async {
      when(() => mockFetchUsersUsecase()).thenThrow(CacheError(payload: {}, stackTrace: StackTrace.fromString('')));

      expect(
        () async => await localSaveUser.call(authEntity: authEntity),
        throwsA(isA<ModelError>()),
      );
    });
  });
}
