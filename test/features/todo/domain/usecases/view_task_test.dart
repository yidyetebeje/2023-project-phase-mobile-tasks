

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoappwithcleanarchitecture/core/failure/not_found.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/repositories/task_repository.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/view_task.dart';

import 'view_all_tasks_test.mocks.dart';

void main(){
  TaskRepository taskRepository = MockTaskRepository();
  ViewTask viewTask = ViewTask(taskRepository);
  setUp(() =>{
    taskRepository = MockTaskRepository(),
    viewTask = ViewTask(taskRepository)
  });
  var todo = Task_(
    id: '1',
    title: 'Create TODO app',
    description: 'Build a simple TODO app in Flutter',
    isDone: false,
    due: DateTime(2023, 8, 15),
  );
  test('should get a todo from the repository', () async {
    when(taskRepository.getTaskById('1')).thenAnswer((_) async => Right(todo));
    final result = await viewTask('1');
    expect(result, Right(todo));
    verify(taskRepository.getTaskById('1'));
    verifyNoMoreInteractions(taskRepository);
  }); 
  test('should get a todo from the repository', () async {
    when(taskRepository.getTaskById('1')).thenAnswer((_) async => Left(NotFound()));
    final result = await viewTask('1');
    expect(result, isA<Left>());
    verify(taskRepository.getTaskById('1'));
    verifyNoMoreInteractions(taskRepository);
  });
}