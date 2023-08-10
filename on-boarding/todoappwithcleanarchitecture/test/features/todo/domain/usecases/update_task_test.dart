import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoappwithcleanarchitecture/core/failure/not_found.dart';
import 'package:todoappwithcleanarchitecture/core/failure/storage_failure.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/update_task.dart';
import 'view_all_tasks_test.mocks.dart';


void main() {
  late UpdateTask usecase;
  late MockTaskRepository mockTaskRepository = MockTaskRepository();

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = UpdateTask(mockTaskRepository);
  });

  final tTask = Task_(id: '1', title: 'Test Task', isDone: false, description: 'Some thing happen', due: DateTime.now());

  test(
    'should update a task in the repository',
    () async {
      // arrange
      when(mockTaskRepository.updateTask(any)).thenAnswer((_) async => Right(tTask));
      // act
      final result = await usecase(tTask);
      // assert
      expect(result, Right(tTask));
      verify(mockTaskRepository.updateTask(tTask)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );

  test(
    'should return a failure when updating a task fails',
    () async {
      // arrange
      when(mockTaskRepository.updateTask(any)).thenAnswer((_) async => Left(StorageFailure()));
      // act
      final result = await usecase(tTask);
      // assert
      expect(result, Left(StorageFailure()));
      verify(mockTaskRepository.updateTask(tTask)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );
  test(
    'should return a failure when a task is not found', () async {
      // arrange
      when(mockTaskRepository.updateTask(any)).thenAnswer((_) async => Left(NotFound()));
      // act
      final result = await usecase(tTask);
      // assert
      expect(result, Left(NotFound()));
      verify(mockTaskRepository.updateTask(tTask)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );
}