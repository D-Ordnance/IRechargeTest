// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/feature/employee/presentation/views/home/view.dart';

void main() {
  testWidgets('Test if widget has title', (WidgetTester tester) async {
    await tester.pumpWidget(const HomeView());
    final titleFinder = find.text('Hello Admin');

    expect(titleFinder, findsOneWidget);
  });
}
