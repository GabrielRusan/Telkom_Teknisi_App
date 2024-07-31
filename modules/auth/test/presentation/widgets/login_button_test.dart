import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:auth/presentation/widgets/login_button.dart';
import 'package:auth/utils/login_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helper/bloc_test_helper.dart';

void main() {
  late MockLoginBloc mockBloc;
  setUp(() {
    mockBloc = MockLoginBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<LoginBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Login Button should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(const LoginState(loginStatus: LoginStatus.inProggres));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const LoginButton()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Login Button should display text Masuk when not loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(const LoginState(loginStatus: LoginStatus.initial));

    final textMasukFinder = find.text('Masuk');

    await tester.pumpWidget(makeTestableWidget(const LoginButton()));

    expect(textMasukFinder, findsOneWidget);
  });
}
