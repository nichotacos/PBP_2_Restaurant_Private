import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbp_2_restaurant/login.dart';
import 'package:pbp_2_restaurant/view/home.dart';
import 'package:pbp_2_restaurant/view/register.dart';
import 'package:pbp_2_restaurant/repository/cart_repository.dart';
import 'package:pbp_2_restaurant/model/cart_model.dart';
import 'package:pbp_2_restaurant/view/menu/itemPageBurger.dart';
import 'package:pbp_2_restaurant/view/cart.dart';

import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  // testWidgets('Register Test', (WidgetTester tester) async {
  //   await tester.binding.setSurfaceSize(const Size(540, 1080));

  //   await tester.pumpWidget(
  //     const MaterialApp(
  //       home: RegisterView(
  //           id: null,
  //           bornDate: null,
  //           email: null,
  //           password: null,
  //           telephone: null,
  //           username: null),
  //     ),
  //   );

  //   expect(find.byKey(const Key('UsernameField')), findsOneWidget);
  //   expect(find.byKey(const Key('PasswordField')), findsOneWidget);
  //   expect(find.byKey(const Key('EmailField')), findsOneWidget);
  //   expect(find.byKey(const Key('TelephoneField')), findsOneWidget);
  //   expect(find.byKey(const Key('DateField')), findsOneWidget);
  //   expect(find.byType(TextFormField), findsNWidgets(5));
  //   await tester.pump(const Duration(seconds: 2));

  //   expect(find.byKey(const Key('CheckboxField')), findsOneWidget);
  //   await tester.pump(const Duration(seconds: 1));

  //   expect(find.byKey(const Key('SignUpButton')), findsOneWidget);
  //   await tester.pump(const Duration(seconds: 1));

  //   await tester.enterText(
  //       find.byKey(const Key('UsernameField')), 'daveSebastian_1487');
  //   await tester.pump(const Duration(seconds: 1));
  //   await tester.enterText(
  //       find.byKey(const Key('EmailField')), '1487@gmail.com');
  //   await tester.pump(const Duration(seconds: 1));
  //   await tester.enterText(find.byKey(const Key('PasswordField')), 'B_1487');
  //   await tester.pump(const Duration(seconds: 1));
  //   await tester.enterText(
  //       find.byKey(const Key('TelephoneField')), '0812345678');
  //   await tester.pump(const Duration(seconds: 1));
  //   await tester.tap(find.byKey(const Key('DateField')));
  //   await tester.pump(const Duration(seconds: 2));
  //   final okButtonFinder = find.text('OK');
  //   await tester.tap(okButtonFinder);
  //   await tester.pumpAndSettle(const Duration(seconds: 2));

  //   await tester.tap(find.byKey(const Key('CheckboxField')));
  //   await tester.pump(const Duration(seconds: 1));

  //   expect(
  //       (tester.widget(find.byKey(const Key('UsernameField'))) as TextFormField)
  //           .controller!
  //           .text,
  //       'daveSebastian_1487');
  //   expect(
  //       (tester.widget(find.byKey(const Key('EmailField'))) as TextFormField)
  //           .controller!
  //           .text,
  //       '1487@gmail.com');
  //   expect(
  //       (tester.widget(find.byKey(const Key('PasswordField'))) as TextFormField)
  //           .controller!
  //           .text,
  //       'B_1487');
  //   expect(
  //       (tester.widget(find.byKey(const Key('TelephoneField')))
  //               as TextFormField)
  //           .controller!
  //           .text,
  //       '0812345678');
  //   expect(
  //       (tester.widget(find.byKey(const Key('DateField'))) as TextFormField)
  //           .controller!
  //           .text,
  //       isNotEmpty);
  //   expect(
  //       (tester.widget(find.byKey(const Key('CheckboxField')))
  //               as CheckboxListTileFormField)
  //           .initialValue,
  //       false);

  //   await tester.tap(find.text('Sign Up'));
  //   // await tester.pump(const Duration(seconds: 4));
  //   await tester.pumpAndSettle();

  //   await tester.tap(find.text('Ok'));
  //   await tester.pump();
  //   await tester.pumpAndSettle();

  //   // await tester.pumpWidget(const MaterialApp(home: LoginView()));
  // });

  testWidgets('Login Test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(540, 1080));

    await tester.pumpWidget(const MaterialApp(
      home: LoginView(),
    ));
    await tester.pump();

    expect(find.byKey(const Key('UsernameField')), findsOneWidget);
    expect(find.byKey(const Key('PasswordField')), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    // await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byKey(const Key('LoginButton')), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(
        find.byKey(const Key('UsernameField')).first, 'daveSebastian_1487');
    await tester.pump(const Duration(seconds: 1));
    await tester.enterText(
        find.byKey(const Key('PasswordField')).first, 'B_1487');
    await tester.pump(const Duration(seconds: 1));

    expect(
        (tester.widget(find.byKey(const Key('UsernameField'))) as TextFormField)
            .controller!
            .text,
        'daveSebastian_1487');
    expect(
        (tester.widget(find.byKey(const Key('PasswordField'))) as TextFormField)
            .controller!
            .text,
        'B_1487');

    await tester.tap(find.byKey(const Key('LoginButton')));
    await tester.pump(const Duration(seconds: 1));

    await tester.pumpWidget(MaterialApp(
      home: HomeView(user: user, pageIndex: 0),
    ));

    // expect(tester.widget(find.byKey(const Key('BurgerPage'))), findsOneWidget);
    // await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byKey(const Key('BurgerPage')).first);
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('IncrementOrder')));
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byKey(const Key('IncrementOrder')));
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byKey(const Key('IncrementOrder')));
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byKey(const Key('AddtoCart')));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(HomeView), findsOneWidget);

    await tester.tap(find.byIcon(Icons.bookmarks_outlined));
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // // Get the position of the first Slidable item
    // final slidableFinder = find.byType(Slidable).first;
    // final slidableContainer = tester.getRect(slidableFinder);

    // // Calculate the swipe action from right to left
    // final double startX = slidableContainer.centerRight.dx - 10;
    // final double endX = slidableContainer.centerLeft.dx + 10;

    // final TestGesture gesture =
    //     await tester.startGesture(Offset(startX, slidableContainer.center.dy));
    // await gesture.moveTo(Offset(endX, slidableContainer.center.dy));
    // await tester.pumpAndSettle();
  });
}
