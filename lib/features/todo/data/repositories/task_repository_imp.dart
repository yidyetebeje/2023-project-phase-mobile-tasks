import 'package:dartz/dartz.dart';
import 'package:todoappwithcleanarchitecture/core/failure/failure.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/datasources/task_api.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository{
  final TaskApi _taskApi;
  TaskRepositoryImpl(this._taskApi);
  @override
  Future<Either<Failure, Task_>> createTask(Task_ task)  => _taskApi.createTask(task);

  @override
  Future<Either<Failure, void>> deleteTask(String id) => _taskApi.deleteTask(id);

  @override
  Future<Either<Failure, Task_>> getTaskById(String id) => _taskApi.getTaskById(id);

  @override
  Stream<List<Task_>> getTasks() => _taskApi.getTasks();

  @override
  Future<Either<Failure, Task_>> updateTask(Task_ task) => _taskApi.updateTask(task); 
}