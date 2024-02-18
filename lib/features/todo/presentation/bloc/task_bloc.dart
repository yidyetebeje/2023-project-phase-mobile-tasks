import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/delete_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/update_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/view_all_tasks.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  ViewAllTasks viewAllTasks;
  UpdateTask  updateTask;
  DeleteTask deleteTask;
  TaskBloc({
    required this.viewAllTasks,
    required this.updateTask,
    required this.deleteTask,
  }): super(const TaskState()) {
    on<TaskSubscriptionRequested>(_onSubscriptionRequested);
    on<TaskCompletionToggled>(_onTaskCompletionToggled);
    on<TaskDeleted>(_onTaskDeleted);
  }

  Future<void> _onSubscriptionRequested(TaskSubscriptionRequested event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: () => TaskStatus.loading));
    await emit.forEach<List<Task_>>(
      viewAllTasks(),
      onData: (tasks) => state.copyWith(
        status: () => TaskStatus.success,
        tasks: () => tasks,
      ),
      onError: (_,__)=> state.copyWith(
        status: () => TaskStatus.failure,
      )
    );
  }

  FutureOr<void> _onTaskCompletionToggled(TaskCompletionToggled event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: ()=> TaskStatus.loading));
    var task = event.task.copyWith(isDone: !event.task.isDone);
    var result = await updateTask(task);
    result.fold(
      (failure) => emit(state.copyWith(status: () => TaskStatus.failure)),
      (task) => emit(state.copyWith(
        status: () => TaskStatus.success,
      )),
    );
  }

  FutureOr<void> _onTaskDeleted(TaskDeleted event, Emitter<TaskState> emit)  async {
    emit(state.copyWith(status: () => TaskStatus.loading));
    var result = await deleteTask(event.task);
    result.fold(
      (failure) => emit(state.copyWith(status: () => TaskStatus.failure)),
      (task) => emit(state.copyWith(
        status: () => TaskStatus.success,
      )),
    );
  }
}
