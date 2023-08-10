import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc() : super(CreateTaskInitial()) {
    on<CreateTaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
