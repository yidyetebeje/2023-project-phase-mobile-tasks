import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/update_task.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  UpdateTask updateTask;
  EditTaskCubit({
    required this.updateTask,
  }) : super(EditTaskInitial());

  Future<void> updateTask_(Task_ task) async {
    emit(EditTaskLoading());
    var result = await updateTask(task);
    result.fold(
      (failure) => emit(EditTaskFailure()),
      (task) => emit(EditTaskSuccess(task: task)),
    );
  }
}
