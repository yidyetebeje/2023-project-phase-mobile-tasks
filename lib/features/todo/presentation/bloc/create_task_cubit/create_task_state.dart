part of 'create_task_cubit.dart';

sealed class CreateTaskState extends Equatable {
  const CreateTaskState();

  @override
  List<Object> get props => [];
}

final class CreateTaskInitial extends CreateTaskState {}
final class CreateTaskLoading extends CreateTaskState {}
final class CreateTaskSuccess extends CreateTaskState {
  final Task_ task;
  const CreateTaskSuccess({required this.task});
  @override
  List<Object> get props => [task];
}
final class CreateTaskFailure extends CreateTaskState {}
