import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/create_task.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTask createTask;
  CreateTaskCubit({
    required this.createTask,
  }) : super(CreateTaskInitial());

  Future<void> createTask_(Task_ task) async {
    emit(CreateTaskLoading());
    var result = await createTask(task);
    result.fold(
      (failure) => emit(CreateTaskFailure()),
      (task) => emit(CreateTaskSuccess(task: task)),
    );
  }
}
