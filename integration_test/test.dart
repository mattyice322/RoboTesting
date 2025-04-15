import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_robo/flutter_flow/flutter_flow_icon_button.dart';
import 'package:testing_robo/flutter_flow/flutter_flow_widgets.dart';
import 'package:testing_robo/flutter_flow/flutter_flow_theme.dart';
import 'package:testing_robo/index.dart';
import 'package:testing_robo/main.dart';
import 'package:testing_robo/flutter_flow/flutter_flow_util.dart';

import 'package:provider/provider.dart';
import 'package:testing_robo/backend/firebase/firebase_config.dart';
import 'package:testing_robo/auth/firebase_auth/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initFirebase();

    await FlutterFlowTheme.initialize();
  });

  setUp(() async {
    await authManager.signOut();
    FFAppState.reset();
    final appState = FFAppState();
    await appState.initializePersistedState();
  });

  testWidgets('User Login', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: MyApp(
        entryPage: LoginPageWidget(),
      ),
    ));
    await GoogleFonts.pendingFonts();

    await tester.pumpAndSettle(const Duration(milliseconds: 20000));
    await tester.enterText(
        find.byKey(const ValueKey('loginEmail_gkw6')), 'jess@gmail.com');
    await tester.enterText(
        find.byKey(const ValueKey('loginPassword_ps56')), 'csc305');
    await tester.tap(find.byKey(const ValueKey('LoginButton_i83y')));
    await tester.pumpAndSettle(const Duration(milliseconds: 20000));
    expect(find.text('Connect'), findsWidgets);
  });

  testWidgets('Onboarding', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: MyApp(
        entryPage: OnBoardingWidget(),
      ),
    ));
    await GoogleFonts.pendingFonts();

    await tester.enterText(find.byKey(const ValueKey('NameVar_s8in')), 'Nadia');
    await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    await tester.tap(find.byKey(const ValueKey('Button_hob0')));
    await tester.pumpAndSettle(const Duration(milliseconds: 10000));
    await tester.enterText(find.byKey(const ValueKey('TextField_hptm')), '22');
    await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    await tester.tap(find.byKey(const ValueKey('Button_miet')));
    await tester.pumpAndSettle(const Duration(milliseconds: 10000));
    expect(find.byKey(const ValueKey('Column_o84v')), findsWidgets);
  });

  testWidgets('Account Creation', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: const MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.tap(find.byKey(const ValueKey('signupEmail_2ckp')));
    await tester.enterText(
        find.byKey(const ValueKey('signupEmail_2ckp')), 'example@gmail.com');
    await tester.tap(find.byKey(const ValueKey('signupPassword_1wnh')));
    await tester.enterText(
        find.byKey(const ValueKey('signupPassword_1wnh')), 'ballislife03');
    await tester.tap(find.byKey(const ValueKey('signupConfirmPassword_kdm9')));
    await tester.enterText(
        find.byKey(const ValueKey('signupConfirmPassword_kdm9')),
        'ballislife03');
    await tester.tap(find.byKey(const ValueKey('Button_kuv7')));
  });

  testWidgets('Wrong Password', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: const MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.tap(find.byKey(const ValueKey('signupEmail_2ckp')));
    await tester.enterText(
        find.byKey(const ValueKey('signupEmail_2ckp')), 'example@gmail.com');
    await tester.tap(find.byKey(const ValueKey('signupPassword_1wnh')));
    await tester.enterText(
        find.byKey(const ValueKey('signupPassword_1wnh')), 'ballislife03');
    await tester.tap(find.byKey(const ValueKey('signupConfirmPassword_kdm9')));
    await tester.enterText(
        find.byKey(const ValueKey('signupConfirmPassword_kdm9')),
        'Ballislife03');
    await tester.tap(find.byKey(const ValueKey('Button_kuv7')));
  });

  testWidgets('No email entered', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: const MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.tap(find.byKey(const ValueKey('signupEmail_2ckp')));
    await tester.tap(find.byKey(const ValueKey('signupPassword_1wnh')));
    await tester.enterText(
        find.byKey(const ValueKey('signupPassword_1wnh')), 'ballislife03');
    await tester.tap(find.byKey(const ValueKey('signupConfirmPassword_kdm9')));
    await tester.enterText(
        find.byKey(const ValueKey('signupConfirmPassword_kdm9')),
        'Ballislife03');
    await tester.tap(find.byKey(const ValueKey('Button_kuv7')));
  });

  testWidgets('No password entered', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: const MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.tap(find.byKey(const ValueKey('signupEmail_2ckp')));
    await tester.tap(find.byKey(const ValueKey('signupPassword_1wnh')));
    await tester.tap(find.byKey(const ValueKey('signupConfirmPassword_kdm9')));
    await tester.tap(find.byKey(const ValueKey('Button_kuv7')));
  });
}

// There are certain types of errors that can happen during tests but
// should not break the test.
void _overrideOnError() {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (errorDetails) {
    if (_shouldIgnoreError(errorDetails.toString())) {
      return;
    }
    originalOnError(errorDetails);
  };
}

bool _shouldIgnoreError(String error) {
  // It can fail to decode some SVGs - this should not break the test.
  if (error.contains('ImageCodecException')) {
    return true;
  }
  // Overflows happen all over the place,
  // but they should not break tests.
  if (error.contains('overflowed by')) {
    return true;
  }
  // Sometimes some images fail to load, it generally does not break the test.
  if (error.contains('No host specified in URI') ||
      error.contains('EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE')) {
    return true;
  }
  // These errors should be avoided, but they should not break the test.
  if (error.contains('setState() called after dispose()')) {
    return true;
  }

  return false;
}
