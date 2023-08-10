import 'package:dartz/dartz.dart';
import 'package:todoappwithcleanarchitecture/core/failure/failure.dart';
import 'package:todoappwithcleanarchitecture/core/usecase/use_case.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/repositories/task_repository.dart';

class ViewTask extends UseCase<Future<Either<Failure, Task_>>, String> {
  final TaskRepository repository;
  ViewTask(this.repository);
  @override
  Future<Either<Failure, Task_>> call(String params) async {
    return await repository.getTaskById(params);
  }
}