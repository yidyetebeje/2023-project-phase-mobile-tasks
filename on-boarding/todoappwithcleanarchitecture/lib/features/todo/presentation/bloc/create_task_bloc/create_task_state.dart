part of 'create_task_bloc.dart';

sealed class CreateTaskState extends Equatable {
  const CreateTaskState();
  
  @override
  List<Object> get props => [];
}

final class CreateTaskInitial extends CreateTaskState {}
