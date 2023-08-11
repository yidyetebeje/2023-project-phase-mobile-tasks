part of 'edit_task_cubit.dart';

sealed class EditTaskState extends Equatable {
  const EditTaskState();

  @override
  List<Object> get props => [];
}

final class EditTaskInitial extends EditTaskState {}
final class EditTaskLoading extends EditTaskState {}
final class EditTaskSuccess extends EditTaskState {
  final Task_ task;
  const EditTaskSuccess({required this.task});
  @override
  List<Object> get props => [task];
}
final class EditTaskFailure extends EditTaskState {}
