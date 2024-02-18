
import 'package:todoappwithcleanarchitecture/core/usecase/no_params_use_case.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';

import '../repositories/task_repository.dart';
class ViewAllTasks extends NoParamsUseCase<Stream<List<Task_>>> {
  final TaskRepository repository;

  ViewAllTasks(this.repository);

  @override
  Stream<List<Task_>> call() {
    return repository.getTasks();
  }
}