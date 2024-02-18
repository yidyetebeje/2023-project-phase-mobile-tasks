import 'package:dartz/dartz.dart';
import 'package:todoappwithcleanarchitecture/core/failure/failure.dart';
import 'package:todoappwithcleanarchitecture/core/usecase/use_case.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/repositories/task_repository.dart';

import '../entities/task.dart';

class DeleteTask extends UseCase<Future<Either<Failure, void>>, Task_> {
  TaskRepository taskRepository;
  DeleteTask(this.taskRepository);
  @override
  Future<Either<Failure, void>> call(Task_ params) async {
    return await taskRepository.deleteTask(params.id);
  }
}