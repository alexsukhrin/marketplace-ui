import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('smoke test: додаток успішно запускається',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: Marcketplace(),
      ),
    );
    expect(find.byType(Marcketplace), findsOneWidget);
  });
}
