
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/datasources/task_api.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/repositories/task_repository_imp.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/repositories/task_repository.dart';

@GenerateNiceMocks([MockSpec<TaskApi>()])
import 'task_repository_test.mocks.dart';

void main() {
  
  late MockTaskApi mockTaskApi = MockTaskApi();
  late TaskRepository repository = TaskRepositoryImpl(mockTaskApi);

  setUp(() {
    mockTaskApi = MockTaskApi();
    repository = TaskRepositoryImpl(mockTaskApi);
  });

  group('createTask', () {
    final tTask = Task_(
      id: '1',
      title: 'Create TODO app',
      description: 'Build a simple TODO app in Flutter',
      isDone: false,
      due: DateTime(2023, 8, 15),
    );

    test(
      'should return task when API call completes successfully',
      () async {
        when(mockTaskApi.createTask(any))
          .thenAnswer((_) async => Right(tTask));

        final result = await repository.createTask(tTask);

        expect(result, Right(tTask));
        verify(mockTaskApi.createTask(tTask));
        verifyNoMoreInteractions(mockTaskApi);
      },
    );
  });
  //   test(
  //     'should return ServerFailure when API call completes with error',
  //     () async {
  //       when(mockTaskApi.createTask(any))
  //         .thenAnswer((_) async => Left(ServerFailure()));

  //       final result = await repository.createTask(tTask);

  //       expect(result, Left(ServerFailure()));
  //       verify(mockTaskApi.createTask(tTask));
  //       verifyNoMoreInteractions(mockTaskApi);
  //     },
  //   );
  // });

  group('deleteTask', () {
    const tId = 'id';

    test(
      'should return unit when delete completes successfully',
      () async {
        when(mockTaskApi.deleteTask(any))
          .thenAnswer((_) async => const Right(unit));

        final result = await repository.deleteTask(tId);

        expect(result, const Right(unit));
        verify(mockTaskApi.deleteTask(tId));
        verifyNoMoreInteractions(mockTaskApi);
      },
    );

    // test(
    //   'should return ServerFailure when delete fails', 
    //   () async {
    //     when(mockTaskApi.deleteTask(any))
    //       .thenAnswer((_) async => Left(ServerFailure()));

    //     final result = await repository.deleteTask(tId);

    //     expect(result, Left(ServerFailure()));
    //     verify(mockTaskApi.deleteTask(tId));
    //     verifyNoMoreInteractions(mockTaskApi);
    //   }
    // );
  });
  group("edit task",(){
    final tTask = Task_(
      id: '1',
      title: 'Create TODO app',
      description: 'Build a simple TODO app in Flutter',
      isDone: false,
      due: DateTime(2023, 8, 15),
    );
    test("should return task when edit completes successfully", () async {
      when(mockTaskApi.updateTask(any))
        .thenAnswer((_) async => Right(tTask));
      final result = await repository.updateTask(tTask);
      expect(result, Right(tTask));
      verify(mockTaskApi.updateTask(tTask));
      verifyNoMoreInteractions(mockTaskApi);
    });
  });
  group("get tasks",(){
   final tTodoList = [
    Task_(
      id: '1',
      title: 'Create TODO app',
      description: 'Build a simple TODO app in Flutter',
      isDone: false,
      due: DateTime(2023, 8, 15),
    ),
    Task_(
      id: '2',
      title: 'Go grocery shopping',
      description: 'Buy milk, eggs, bread',
      isDone: true,
      due: DateTime(2023, 8, 10),
    ),
    Task_(
      id: '3',
      title: 'Pay electric bill',
      description: 'Pay online or in-person before due date',
      isDone: false,
      due: DateTime(2023, 8, 20),
    )
  ];
    test("should return list of tasks when get tasks completes successfully", () async {
      when(mockTaskApi.getTasks())
        .thenAnswer((_) => Stream.value(tTodoList));
      final result = repository.getTasks();
      expect(result, emits(tTodoList));
      verify(mockTaskApi.getTasks());
      verifyNoMoreInteractions(mockTaskApi);
    });
  });
  
  // Tests for other methods
}