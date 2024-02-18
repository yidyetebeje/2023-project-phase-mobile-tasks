import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/delete_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/update_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/bloc/task_bloc.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/task_list.dart';

import '../bloc/task_bloc_test.mocks.dart';
void main() {
  group('TaskList', () {
    late TaskBloc taskBloc;
    late UpdateTask mockUpdateTask;
    late DeleteTask mockDeleteTask;
    late ViewAllTasks mockViewAllTasks;
    setUp(() {
      mockViewAllTasks = MockViewAllTasks();
      mockUpdateTask = MockUpdateTask();
      mockDeleteTask = MockDeleteTask();
      taskBloc = TaskBloc(
        viewAllTasks: mockViewAllTasks,
        updateTask: mockUpdateTask,
        deleteTask: mockDeleteTask,
      );
    });

    testWidgets('renders CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      when(mockViewAllTasks()).thenAnswer((_) => Stream.value([
            Task_(
                id: '1',
                title: 'Test Task',
                description: 'This is a test task',
                isDone: false,
                due: DateTime.now())
          ]));
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: taskBloc,
            child: const TaskList(),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays correct number of tasks when status is success',
        (WidgetTester tester) async {
      // Set up mock data
      final tasks = [
        Task_(
            id: '1',
            title: 'Task 1',
            description: 'This is task 1',
            isDone: false,
            due: DateTime.now()),
        Task_(
            id: '2',
            title: 'Task 2',
            description: 'This is task 2',
            isDone: false,
            due: DateTime.now()),
        Task_(
            id: '3',
            title: 'Task 3',
            description: 'This is task 3',
            isDone: false,
            due: DateTime.now()),
      ];
      when(mockViewAllTasks()).thenAnswer((_) => Stream.value(tasks));

      taskBloc = TaskBloc(
        viewAllTasks: mockViewAllTasks,
        updateTask: mockUpdateTask,
        deleteTask: mockDeleteTask,
      );
      taskBloc.add(const TaskSubscriptionRequested());
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: taskBloc,
            child: const TaskList(),
          ),
        ),
      );

      // Check that the widget displays the correct number of tasks
      expect(find.byType(TaskTile), findsNWidgets(tasks.length));
    });
    testWidgets(
        'updates task completion status correctly when checkbox is tapped',
        (WidgetTester tester) async {
      // Set up mock data
      final tasks = [
        Task_(
            id: '1',
            title: 'Task 1',
            description: 'This is task 1',
            isDone: false,
            due: DateTime.now()),
        Task_(
            id: '2',
            title: 'Task 2',
            description: 'This is task 2',
            isDone: false,
            due: DateTime.now()),
        Task_(
            id: '3',
            title: 'Task 3',
            description: 'This is task 3',
            isDone: false,
            due: DateTime.now()),
      ];
      when(mockViewAllTasks()).thenAnswer((_) => Stream.value(tasks));

      taskBloc = TaskBloc(
        viewAllTasks: mockViewAllTasks,
        updateTask: mockUpdateTask,
        deleteTask: mockDeleteTask,
      );
      taskBloc.add(const TaskSubscriptionRequested());
      var task = tasks[1].copyWith(isDone: true);
      when(mockUpdateTask.call(task)).thenAnswer((_) async => Right(task));
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: taskBloc,
            child: const TaskList(),
          ),
        ),
      );

      // Wait for the widget to settle

      // Tap the checkbox of the second task to mark it as done
      final secondTaskTile = find.byKey(Key(tasks[1].id));
      final checkbox =
          find.descendant(of: secondTaskTile, matching: find.byType(Checkbox));
      await tester.tap(checkbox);

      // Verify that the corresponding UpdateTask event was dispatched to the TaskBloc
      verify(mockUpdateTask.call(task)).called(1);
    });
  //   testWidgets('deletes a task correctly when swiped',
  //       (WidgetTester tester) async {
  //     // Set up mock data
  //     final tasks = [
  //       Task_(
  //           id: '1',
  //           title: 'Task 1',
  //           description: 'This is task 1',
  //           isDone: false,
  //           due: DateTime.now()),
  //       Task_(
  //           id: '2',
  //           title: 'Task 2',
  //           description: 'This is task 2',
  //           isDone: false,
  //           due: DateTime.now()),
  //       Task_(
  //           id: '3',
  //           title: 'Task 3',
  //           description: 'This is task 3',
  //           isDone: false,
  //           due: DateTime.now()),
  //     ];
  //      taskBloc = TaskBloc(
  //       viewAllTasks: mockViewAllTasks,
  //       updateTask: mockUpdateTask,
  //       deleteTask: mockDeleteTask,
  //     );
  //     when(mockViewAllTasks()).thenAnswer((_) => Stream.value(tasks));
  //      taskBloc.add(const TaskSubscriptionRequested());
  //     var task = tasks[1];
  //     when(mockDeleteTask.call(task)).thenAnswer((_) async => Right(task));

  //     // Build the widget
  //     await tester.pumpWidget(
  //       MaterialApp(
  //         home: BlocProvider.value(
  //           value: taskBloc,
  //           child: const TaskList(),
  //         ),
  //       ),
  //     );

  //     // Wait for the widget to settle
    

  //     // Swipe the second task to delete it
  //     final secondTaskTile = find.byKey(Key('${task.id}_tile'));
    
  //     await tester.drag(secondTaskTile, const Offset(-1000.0, 0.0));
  // await tester.pumpAndSettle();
  //     taskBloc.add(TaskSubscriptionRequested());

  //     // Verify that the corresponding DeleteTask event was dispatched to the TaskBloc
  //     verify(mockDeleteTask(task)).called(1);
  //   });
  });
}
