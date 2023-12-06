import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:pbp_2_restaurant/login.dart' as login;
import 'package:pbp_2_restaurant/view/home.dart';
import 'package:pbp_2_restaurant/view/register.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login Test', (WidgetTester tester) async {
    login.LoginView();
    // await tester.pumpWidget(MaterialApp(
    //   home: LoginView(),
    // ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('UsernameField')), findsOneWidget);
    expect(find.byKey(const Key('PasswordField')), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    // await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byKey(const Key('LoginButton')), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(
        find.byKey(const Key('UsernameField')).first, 'nicho');
    await tester.pump(const Duration(seconds: 1));
    await tester.enterText(
        find.byKey(const Key('PasswordField')).first, 'nicho123');
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byKey(const Key('LoginButton')));
  });
}
