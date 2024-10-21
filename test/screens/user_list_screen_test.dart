import 'package:bloc_sample_app/blocs/user_bloc/user_bloc.dart';
import 'package:bloc_sample_app/blocs/user_bloc/user_event.dart';
import 'package:bloc_sample_app/blocs/user_bloc/user_state.dart';
import 'package:bloc_sample_app/data/entities/user.dart';
import 'package:bloc_sample_app/ui/screens/user_form_screen.dart';
import 'package:bloc_sample_app/ui/screens/user_list_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

void main() {
  late MockUserBloc mockUserBloc;

  setUp(() {
    mockUserBloc = MockUserBloc();
  });

  tearDown(() {
    mockUserBloc.close();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<UserBloc>.value(
      value: mockUserBloc,
      child: MaterialApp(
        home: UserListScreen(),
      ),
    );
  }

  group('UserListScreen', () {
    testWidgets('renders loading indicator when state is UserLoading', (tester) async {
      when(() => mockUserBloc.state).thenReturn(UserLoading());

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders user list when state is UserLoaded', (tester) async {
      final users = [
        User(name: 'User1', email: 'user1@example.com'),
        User(name: 'User2', email: 'user2@example.com'),
      ];
      when(() => mockUserBloc.state).thenReturn(UserLoaded(users));

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('User1'), findsOneWidget);
      expect(find.text('User2'), findsOneWidget);
    });

    testWidgets('renders error message when state is UserError', (tester) async {
      when(() => mockUserBloc.state).thenReturn(UserError('Failed to load users'));

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Failed to load users'), findsOneWidget);
    });

    testWidgets('navigates to UserFormScreen when floating action button is tapped', (tester) async {
      when(() => mockUserBloc.state).thenReturn(UserLoaded([]));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(UserFormScreen), findsOneWidget);
    });
  });
}
