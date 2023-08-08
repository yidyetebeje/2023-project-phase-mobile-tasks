
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:todoappwithcleanarchitecture/core/failure/failure.dart';
import 'package:todoappwithcleanarchitecture/core/usecase/NoParams.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/Todo.dart';

import '../repositories/TodoRepository.dart';
class ViewAllTasks extends NoParamsUseCase<Stream<List<Todo>>> {
  final TodoRepository repository;

  ViewAllTasks(this.repository);

  @override
  Stream<List<Todo>> call() {
    return repository.getTodos();
  }
}