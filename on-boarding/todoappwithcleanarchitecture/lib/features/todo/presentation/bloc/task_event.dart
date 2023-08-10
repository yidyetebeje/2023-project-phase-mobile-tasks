part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}
final class TaskSubscriptionRequested extends TaskEvent {
  const TaskSubscriptionRequested();
}
final class TaskCompletionToggled extends TaskEvent {
  final Task_ task;
  const TaskCompletionToggled({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}
final class TaskDeleted extends TaskEvent {
  final Task_ task;
  const TaskDeleted({required this.task});
  @override
  List<Object> get props => [task];
}
final class TaskCreated extends TaskEvent {
  final Task_ task;
  const TaskCreated({required this.task});
}