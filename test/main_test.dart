// lib/main_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sunny16/main.dart';




void main() {
  group('MyApp Tests', () {
    testWidgets('MyApp widget is created correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}