import 'package:bloc_sample_app/blocs/user_bloc/user_bloc.dart';
import 'package:bloc_sample_app/blocs/user_bloc/user_event.dart';
import 'package:bloc_sample_app/blocs/user_bloc/user_state.dart';
import 'package:bloc_sample_app/data/models/user_model.dart';
import 'package:bloc_sample_app/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock ApiService class
class 
MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late UserBloc userBloc;

  setUp(() {
    mockApiService = MockApiService();
    userBloc = UserBloc(apiService: mockApiService);
  });

  tearDown(() {
    userBloc.close();
  });

  group('UserBloc', () {
    final user1 = UserModel(name: 'User1', email: 'user1@example.com');
    final user2 = UserModel(name: 'User2', email: 'user2@example.com');
    final users = [user1, user2];

    test('initial state is UserInitial', () {
      expect(userBloc.state, UserInitial());
    });

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when FetchUsers is added and API call is successful',
      build: () {
        when(() => mockApiService.getUsers()).thenAnswer((_) async => users);
        return userBloc;
      },
      act: (bloc) => bloc.add(LoadUsers()),
      expect: () => [
        UserLoading(),
        UserLoaded(users),
      ],
      verify: (_) {
        verify(() => mockApiService.getUsers()).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when FetchUsers is added and API call fails',
      build: () {
        when(() => mockApiService.getUsers()).thenThrow(Exception('Failed to load users'));
        return userBloc;
      },
      act: (bloc) => bloc.add(LoadUsers()),
      expect: () => [
        UserLoading(),
        UserError('Failed to load users'),
      ],
      verify: (_) {
        verify(() => mockApiService.getUsers()).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when AddUser is added and API call is successful',
      build: () {
        when(() => mockApiService.createUser(any(), any())).thenAnswer((_) async => Future.value());
        when(() => mockApiService.getUsers()).thenAnswer((_) async => users);
        return userBloc;
      },
      act: (bloc) => bloc.add(AddUser('New User', 'newuser@example.com')),
      expect: () => [
        UserLoading(),
        UserLoaded(users),
      ],
      verify: (_) {
        verify(() => mockApiService.createUser('New User', 'newuser@example.com')).called(1);
        verify(() => mockApiService.getUsers()).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when AddUser is added and API call fails',
      build: () {
        when(() => mockApiService.createUser(any(), any())).thenThrow(Exception('Failed to add user'));
        return userBloc;
      },
      act: (bloc) => bloc.add(AddUser('New User', 'newuser@example.com')),
      expect: () => [
        UserLoading(),
        UserError('Failed to add user'),
      ],
      verify: (_) {
        verify(() => mockApiService.createUser('New User', 'newuser@example.com')).called(1);
      },
    );
  });
}
