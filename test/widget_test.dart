// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:blipin_vendor/pages/create_menu_success_page/create_menu_success_page.dart';
import 'package:blipin_vendor/pages/launcher_page/launcher_page.dart';

void main() {
  testWidgets('launcher onboarding alert matches the first truck state', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(375, 812);
    addTearDown(tester.view.reset);

    var createTruckPressed = false;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LauncherPage(onCreateTruck: () => createTruckPressed = true),
      ),
    );

    expect(find.text('開始建立你的第一台攤車！'), findsOneWidget);
    expect(find.text('建立後即可解鎖其他功能'), findsOneWidget);
    expect(find.text('攤車照片'), findsOneWidget);
    expect(find.text('排程'), findsOneWidget);

    await tester.tap(find.byKey(const Key('create-truck-button')));
    expect(createTruckPressed, isTrue);
  });

  testWidgets('create menu success clears the stack before launcher', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const CreateMenuSuccessPage(),
                ),
              ),
              child: const Text('open success page'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open success page'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('前往首頁'));
    await tester.pumpAndSettle();

    expect(find.byType(LauncherPage), findsOneWidget);
    final launcherContext = tester.element(find.byType(LauncherPage));
    expect(Navigator.canPop(launcherContext), isFalse);
  });
}
