import 'package:bloc_sample_app/blocs/user_bloc/user_bloc.dart';
import 'package:bloc_sample_app/blocs/user_bloc/user_event.dart';
import 'package:bloc_sample_app/blocs/user_bloc/user_state.dart';
import 'package:bloc_sample_app/ui/screens/user_form_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
        home: UserFormScreen(),
      ),
    );
  }

  group('UserFormScreen', () {
    testWidgets('renders the form', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(FormBuilder), findsOneWidget);
    });

    testWidgets('shows validation errors if form is submitted empty', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('This field cannot be empty.'), findsNWidgets(2));
    });

    testWidgets('submits form if all fields are filled', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(FormBuilderTextField).at(0), 'New User');
      await tester.enterText(find.byType(FormBuilderTextField).at(1), 'newuser@example.com');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(() => mockUserBloc.add(AddUser('New User', 'newuser@example.com'))).called(1);
    });
  });
}
