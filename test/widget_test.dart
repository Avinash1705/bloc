import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blocPlants/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // App should render MaterialApp
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Shows loading indicator on startup',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());
        // 🔑 Allow Bloc state -> UI rebuild
        await tester.pump();
        // Immediately after launch, loading should appear
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
}
