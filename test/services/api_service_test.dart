import 'package:bloc_sample_app/data/entities/user.dart';
import 'package:bloc_sample_app/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ApiService apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiService = ApiService(mockDio);
  });

  group('ApiService', () {
    final user1 = User(name: 'User1', email: 'user1@example.com');
    final user2 = User(name: 'User2', email: 'user2@example.com');
    final users = [user1, user2];

    test('getUsers returns list of users when successful', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: [
            {'name': 'User1', 'email': 'user1@example.com'},
            {'name': 'User2', 'email': 'user2@example.com'},
          ],
        ),
      );

      final result = await apiService.getUsers();
      expect(result, users);
    });

    test('getUsers throws exception when failed', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      );

      expect(apiService.getUsers(), throwsException);
    });

    test('addUser calls API with correct parameters', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 201,
        ),
      );

      await apiService.createUser('New User', 'newuser@example.com');
      verify(() => mockDio.post(
            any(),
            data: {'name': 'New User', 'email': 'newuser@example.com'},
          )).called(1);
    });

    test('addUser throws exception when failed', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      );

      expect(apiService.createUser('New User', 'newuser@example.com'), throwsException);
    });
  });
}
