// Mock create task cubit
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/create_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/bloc/create_task_cubit/create_task_cubit.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/create_task_page.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/task_list.dart';
import 'package:todoappwithcleanarchitecture/main.dart';
import 'package:todoappwithcleanarchitecture/service_locator.dart';

import '../bloc/task_bloc_test.mocks.dart';

class MockCreateTaskCubit extends MockCubit<CreateTaskState>
    implements CreateTaskCubit {}

void main() {
  late CreateTaskCubit createTaskCubit;
  late CreateTask mockCreateTask;

  setUp(() {
    mockCreateTask = MockCreateTask();
    createTaskCubit = CreateTaskCubit(createTask: mockCreateTask);
  });

  testWidgets('AddTaskPage invalid title', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddTaskPage(createTaskCubit: createTaskCubit),
    ));

    // Tap submit without entering title
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    // Verify error message
    expect(find.text('Please enter some text'), findsOneWidget);
  });

  testWidgets('AddTaskPage invalid date', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddTaskPage(createTaskCubit: createTaskCubit),
    ));

    // Enter valid title
    await tester.enterText(find.byType(TextFormField).first, 'Task 1');

    // Tap submit without selecting date
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    // Verify error
    expect(find.text('Please select a due date'), findsOneWidget);
  });
  // check the data is saved correctly
  testWidgets(
      'AddTaskPage valid data and successfully navigate to the next page',
      (tester) async {
    var addTaskPage = AddTaskPage(createTaskCubit: createTaskCubit);
    await tester.pumpWidget(MaterialApp(
      home: addTaskPage,
      routes: {
        TaskAppPageRoutes.taskList: (context) => const Placeholder(),
      },
    ));
    await tester.enterText(find.byType(TextFormField).first, 'Task 1');
    addTaskPage.dueDate = DateTime.now();
    when(mockCreateTask(addTaskPage.task))
        .thenAnswer((_) async => Right(addTaskPage.task));
    await tester.tap(find.byType(FilledButton));

    await tester.pumpAndSettle();
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
