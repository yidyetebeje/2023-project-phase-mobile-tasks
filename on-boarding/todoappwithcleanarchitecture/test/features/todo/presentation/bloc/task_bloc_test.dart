
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/delete_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/update_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/bloc/task_bloc.dart';
import 'task_bloc_test.mocks.dart';


@GenerateNiceMocks([MockSpec<ViewAllTasks>(), MockSpec<UpdateTask>(), MockSpec<DeleteTask>()])
void main() {
  final tTaskModel = Task_(
    id: '1',
    title: 'Test Task',
    description: 'This is a test task',
    isDone: false,
    due: DateTime.now(),
  );
  group('TaskBloc', () {
    late ViewAllTasks mockViewAllTasks;
    late UpdateTask mockUpdateTask;
    late DeleteTask mockDeleteTask;
    setUp(() {
      mockViewAllTasks = MockViewAllTasks();
      mockUpdateTask = MockUpdateTask();
      mockDeleteTask = MockDeleteTask();
    });
    test('emits loading and success states on TaskSubscriptionRequested', () async {
      // Arrange
      when(mockViewAllTasks()).thenAnswer((_) => Stream.value([tTaskModel]));
      final bloc = TaskBloc(viewAllTasks: mockViewAllTasks, updateTask: mockUpdateTask, deleteTask: mockDeleteTask);

      // Act
      bloc.add(const TaskSubscriptionRequested());

      // Assert
      await expectLater(
        bloc.stream,
        emitsInOrder([
          const TaskState(status: TaskStatus.loading),
          TaskState(status: TaskStatus.success, tasks: [tTaskModel]),
        ]),
      );
      verify(mockViewAllTasks());
    });
    test("emits loading and failure states on TaskSubscriptionRequest failed", () async {
      // Arrange
      when(mockViewAllTasks()).thenAnswer((_) => Stream.error(Exception()));
      final bloc = TaskBloc(viewAllTasks: mockViewAllTasks, updateTask: mockUpdateTask, deleteTask: mockDeleteTask);

      // Act
      bloc.add(const TaskSubscriptionRequested());

      // Assert
      await expectLater(
        bloc.stream,
        emitsInOrder([
          const TaskState(status: TaskStatus.loading),
          const TaskState(status: TaskStatus.failure),
        ]),
      );
      verify(mockViewAllTasks());
    });
  });
  group("toggle task status", (){
    late ViewAllTasks mockViewAllTasks;
    late UpdateTask mockUpdateTask;
    late DeleteTask mockDeleteTask;
    setUp(() {
      mockViewAllTasks = MockViewAllTasks();
      mockUpdateTask = MockUpdateTask();
      mockDeleteTask = MockDeleteTask();
    });
    test("emits loading and success states on TaskToggled", () async {
      when(mockViewAllTasks()).thenAnswer((_) => Stream.value([tTaskModel]));
      when(mockUpdateTask(tTaskModel.copyWith(isDone: !tTaskModel.isDone))).thenAnswer((_) async => Right(tTaskModel));
      final bloc = TaskBloc(viewAllTasks: mockViewAllTasks, updateTask: mockUpdateTask, deleteTask: mockDeleteTask);
      bloc.add(const TaskSubscriptionRequested());
      bloc.add(TaskCompletionToggled(task: tTaskModel));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          const TaskState(status: TaskStatus.loading),
          TaskState(status: TaskStatus.success, tasks: [tTaskModel]),
          TaskState(status: TaskStatus.loading, tasks: [tTaskModel]),
          TaskState(status: TaskStatus.success, tasks: [tTaskModel])
        ]),
      );
    });
  });
}