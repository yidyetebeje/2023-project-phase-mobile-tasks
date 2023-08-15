import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoappwithcleanarchitecture/core/failure/not_found.dart';
import 'package:todoappwithcleanarchitecture/core/failure/storage_failure.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/datasources/task_local_data_source.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/models/task_model.dart';
import 'task_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
main() async {
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  var taskLocalDataSource =
      TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
  setUp(() async {
    mockSharedPreferences = MockSharedPreferences();
    taskLocalDataSource =
        TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
  });
  final tTaskModel = TaskModel(
    id: '1',
    title: 'Test Task',
    description: 'This is a test task',
    isDone: false,
    due: DateTime.now(),
  );

  final tTask = tTaskModel;
  test(
    'should return a list of tasks from SharedPreferences',
    () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(json.encode([tTaskModel.toJson()]));
      taskLocalDataSource =
          TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
      // act
      final result = taskLocalDataSource.getTasks();
      // assert
      expect(result, emits([tTaskModel]));
      verify(mockSharedPreferences
          .getString(TaskLocalDataSource.kTodosCollectionKey));
    },
  );
  test(
    'should create a task in SharedPreferences, return the task, and emit the stream',
    () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(json.encode([]));
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) => Future.value(true));
      taskLocalDataSource =
          TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
      // act
      final result = await taskLocalDataSource.createTask(tTask);
      // assert
      expect(result, Right(tTask));
      verify(mockSharedPreferences.setString(
          TaskLocalDataSource.kTodosCollectionKey, any));
      expectLater(taskLocalDataSource.getTasks(), emits([tTask]));
    },
  );
  group('deleteTask', () {
    test(
      'should delete a task from SharedPreferences and return unit',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(json.encode([tTaskModel.toJson()]));
        when(mockSharedPreferences.setString(any, any))
            .thenAnswer((_) => Future.value(true));
        taskLocalDataSource =
            TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
        // act
        final result = await taskLocalDataSource.deleteTask('1');
        // assert
        expect(result, const Right(unit));
        verify(mockSharedPreferences.setString(
            TaskLocalDataSource.kTodosCollectionKey, any));
        expectLater(taskLocalDataSource.getTasks(), emits([]));
      },
    );

    test(
      'should return a NotFound failure when the task is not found',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(json.encode([]));
        taskLocalDataSource =
            TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
        // act
        final result = await taskLocalDataSource.deleteTask('1');

        // assert
        expect(result, Left(NotFound()));
      },
    );

    test(
      'should return a StorageFailure when SharedPreferences throws an error',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(json.encode([tTaskModel.toJson()]));
        when(mockSharedPreferences.setString(any, any)).thenThrow(Exception());
        taskLocalDataSource =
            TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
        // act
        final result = await taskLocalDataSource.deleteTask('1');
        // assert
        expect(result, Left(StorageFailure()));
      },
    );
  });

  group('updateTask', () {
    test(
      'should update a task in SharedPreferences, return the task, and fire the stream',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(json.encode([tTaskModel.toJson()]));
        when(mockSharedPreferences.setString(any, any))
            .thenAnswer((_) => Future.value(true));
        taskLocalDataSource =
            TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
        // act
        final result = await taskLocalDataSource.updateTask(tTask);
        // assert
        expect(result, Right(tTask));
        verify(mockSharedPreferences.setString(
            TaskLocalDataSource.kTodosCollectionKey, any));
        expectLater(taskLocalDataSource.getTasks(), emits([tTask]));
      },
    );

    test(
      'should return a NotFound failure when the task is not found',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(json.encode([]));
        // act
        final result = await taskLocalDataSource.updateTask(tTask);
        // assert
        expect(result, Left(NotFound()));
      },
    );

    test(
      'should return a StorageFailure when SharedPreferences throws an error',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(json.encode([tTaskModel.toJson()]));
        when(mockSharedPreferences.setString(any, any)).thenThrow(Exception());
        taskLocalDataSource =
            TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
        // act
        final result = await taskLocalDataSource.updateTask(tTask);
        // assert
        expect(result, Left(StorageFailure()));
      },
    );
  });
  group('getTaskById', () {
    test(
      'should return a task from SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(json.encode([tTaskModel.toJson()]));
        taskLocalDataSource =
            TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
        // act
        final result = await taskLocalDataSource.getTaskById('1');
        // assert
        expect(result, Right(tTask));
      },
    );

    test(
      'should return a NotFound failure when the task is not found',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(json.encode([]));
        taskLocalDataSource =
            TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
        // act
        final result = await taskLocalDataSource.getTaskById('1');
        // assert
        expect(result, Left(NotFound()));
      },
    );
  });
}
