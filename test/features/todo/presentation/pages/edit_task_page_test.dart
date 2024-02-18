// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
// import 'package:todoappwithcleanarchitecture/features/todo/presentation/bloc/edit_task_cubit/edit_task_cubit.dart';
// import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/onboarding.dart';
// import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/task_edit_page.dart';
// import 'package:todoappwithcleanarchitecture/main.dart';

// import '../bloc/task_bloc_test.mocks.dart';

// void main() {
//   late EditTaskCubit editTaskCubit;
//   late Task_ task;
//   late MockUpdateTask mockUpdateTask;

//   setUp(() {
//     task = Task_(
//       id: '1',
//       title: 'Task 1',
//       description: 'This is task 1',
//       isDone: false,
//       due: DateTime.now(),
//     );
//     mockUpdateTask = MockUpdateTask();
//     editTaskCubit = EditTaskCubit(updateTask: mockUpdateTask);
//   });

//   testWidgets('displays task details correctly', (WidgetTester tester) async {
//     // Build the widget
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider.value(
//           value: editTaskCubit,
//           child: TaskDetailPage(task: task),
//         ),
//       ),
//     );

//     // Verify that the task details are displayed correctly
//     expect(find.byKey(const Key('title')), findsOneWidget);
//     expect(find.text(task.title), findsOneWidget);
//     expect(find.byKey(const Key('description')), findsOneWidget);
//     expect(find.text(task.description), findsOneWidget);
//     expect(find.byKey(const Key('due_date')), findsOneWidget);
//   });

//   testWidgets('updates task correctly when form is submitted',
//       (WidgetTester tester) async {
//     // Build the widget
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider.value(
//           value: editTaskCubit,
//           child: TaskDetailPage(task: task),
//         ),
//         routes: {
//           '/edit_task': (context) => BlocProvider.value(
//                 value: editTaskCubit,
//                 child: TaskDetailPage(task: task),
//               ),
//           TaskAppPageRoutes.taskList: (context) => OnBoardingPage(),
//         },
//       ),
//     );

//     // Enter new task details
//     final newTitle = 'New Task Title';
//     final newDescription = 'This is the new task description';

//     // Submit the form
//     final updatedTask = Task_(
//       id: task.id,
//       title: newTitle,
//       description: newDescription,
//       isDone: task.isDone,
//       due: task.due,
//     );
//     when(mockUpdateTask(any)).thenAnswer((_) async => Right(updatedTask));
//     expect(find.byType(FilledButton), findsOneWidget);
//     // Tap the button and trigger a frame.
//     await tester.tap(find.byType(FilledButton));
//     await tester.pumpAndSettle();
//     expect(find.byType(OnBoardingPage), findsOneWidget);
//     // Verify that the task was updated correctly

//     // verify(mockUpdateTask(updatedTask)).called(1);
//   });
// }
