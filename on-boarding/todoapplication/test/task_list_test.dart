import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapplication/Task.dart';
import 'package:todoapplication/main.dart';
import 'package:todoapplication/screens/task_list.dart';

void main() {
  group('TaskListPage', () {
    testWidgets('should display the correct UI elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: TaskListPage(),
      ));

      expect(find.text('Todo List'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Task list'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('create task'), findsOneWidget);
    });

    testWidgets(
        'should navigate to the task detail page when a task tile is tapped',
        (WidgetTester tester) async {
      final task = Task(
        title: 'Task Name',
        description: 'Buy a new phone',
        due: DateTime.now(),
      );

      await tester.pumpWidget(MaterialApp(
        home: TaskListPage(),
        routes: {
          TodoPageRoutes.taskDetail: (context) => Container(),
        },
      ));

      await tester.tap(find.byKey(const Key('0')));
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsOneWidget);
    });
    testWidgets('should render three task list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: TaskListPage(),
      ));

      expect(find.byType(TaskTile), findsNWidgets(2));
    });
  });
}
