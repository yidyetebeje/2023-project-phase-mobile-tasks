import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoappwithcleanarchitecture/core/failure/storage_failure.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/delete_task.dart';

import 'view_all_tasks_test.mocks.dart';



void main() {
  late DeleteTask usecase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = DeleteTask(mockTaskRepository);
  });

  final tTask = Task_(id: '1', title: 'Test Task', isDone: false, description: 'dsjaksak', due: DateTime.now());

  test(
    'should delete a task from the repository',
    () async {
      // arrange
      when(mockTaskRepository.deleteTask(any)).thenAnswer((_) async => const Right(null));
      // act
      final result = await usecase(tTask);
      // assert
      expect(result, const Right(null));
      verify(mockTaskRepository.deleteTask(tTask.id)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );

  test(
    'should return a failure when deleting a task fails',
    () async {
      // arrange
      when(mockTaskRepository.deleteTask(any)).thenAnswer((_) async => Left(StorageFailure()));
      // act
      final result = await usecase(tTask);
      // assert
      expect(result, Left(StorageFailure()));
      verify(mockTaskRepository.deleteTask(tTask.id)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );
}