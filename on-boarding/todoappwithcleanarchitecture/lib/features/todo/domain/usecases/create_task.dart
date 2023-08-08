import 'package:dartz/dartz.dart';
import 'package:todoappwithcleanarchitecture/core/failure/failure.dart';
import 'package:todoappwithcleanarchitecture/core/usecase/UseCase.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';

import '../repositories/task_repository.dart';

class CreateTask extends UseCase<Future<Either<Failure, Task_>>, Task_> {
  final TaskRepository repository;

  CreateTask(this.repository);

  @override
  Future<Either<Failure, Task_>> call(Task_ task) async {
    return await repository.createTask(task);
  }
}