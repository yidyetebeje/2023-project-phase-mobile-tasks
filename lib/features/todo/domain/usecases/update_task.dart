import 'package:dartz/dartz.dart';
import 'package:todoappwithcleanarchitecture/core/failure/failure.dart';
import 'package:todoappwithcleanarchitecture/core/usecase/use_case.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/repositories/task_repository.dart';

import '../entities/task.dart';

class UpdateTask extends UseCase<Future<Either<Failure, Task_>>, Task_> {
  TaskRepository taskRepository;
  UpdateTask(this.taskRepository);
  @override
  Future<Either<Failure, Task_>> call(Task_ params) async {
    return await taskRepository.updateTask(params);
  }
}