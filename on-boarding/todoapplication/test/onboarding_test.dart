import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapplication/main.dart';
import 'package:todoapplication/screens/onboarding.dart';
import 'package:todoapplication/screens/task_list.dart';

void main() {
  testWidgets('OnBoardingPage navigation test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: OnBoardingPage(), routes: {
      TodoPageRoutes.taskList: (context) => const TaskListPage(),
    }));

    // Verify image and button are present
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);

    // Tap the button
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    // Verify navigation to taskList page
    expect(find.byType(TaskListPage), findsOneWidget);
  });
}
