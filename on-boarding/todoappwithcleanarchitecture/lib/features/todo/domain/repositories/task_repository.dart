import 'package:dartz/dartz.dart';
import 'package:todoappwithcleanarchitecture/core/failure/failure.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';

abstract class TaskRepository {
  Stream<List<Task_>> getTasks();
  Future<Either<Failure, Task_>> getTaskById(String id);
  Future<Either<Failure, Task_>> createTask(Task_ task);
  Future<Either<Failure, Task_>> updateTask(Task_ task);
  Future<Either<Failure, void>> deleteTask(String id);
}