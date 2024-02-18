part of 'task_bloc.dart';
enum TaskStatus {initial, loading, success, failure}
final class TaskState extends Equatable {
  const TaskState({
    this.status = TaskStatus.initial,
    this.tasks = const [],
  });
  final TaskStatus status;
  final List<Task_> tasks;
  TaskState copyWith({
    TaskStatus Function()?  status,
    List<Task_> Function()? tasks,
  }) {
    return TaskState(
      status: status?.call() ?? this.status,
      tasks: tasks?.call() ?? this.tasks,
    );
  }
  @override
  List<Object> get props => [status, tasks];
}


