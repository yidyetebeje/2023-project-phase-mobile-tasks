import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/repositories/task_repository.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/create_task.dart';

import 'view_all_tasks_test.mocks.dart';

void main(){ 
  TaskRepository taskRepository = MockTaskRepository();
  CreateTask usecase = CreateTask(taskRepository);
  setUp((){
    taskRepository = MockTaskRepository();
    usecase = CreateTask(taskRepository);
  });
  var task_ = Task_(
    id: '1',
    title: 'Create TODO app',
    description: 'Build a simple TODO app in Flutter',
    isDone: false,
    due: DateTime(2023, 8, 15),
  );
  test('should create a todo from the repository', () async {
    when(taskRepository.createTask(task_)).thenAnswer((_) async => Right(task_));
    final result = await usecase(task_);
    expect(result, Right(task_));
    verify(taskRepository.createTask(task_));
    verifyNoMoreInteractions(taskRepository);
  });
  
}