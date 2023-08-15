import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/repositories/task_repository.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<TaskRepository>()])
import 'view_all_tasks_test.mocks.dart';

void main() {
  late ViewAllTasks viewAllTasks;
  late TaskRepository repository;

  setUp(() {
    repository = MockTaskRepository();
    viewAllTasks = ViewAllTasks(repository);
  });

  final tTodoList = [
    Task_(
      id: '1',
      title: 'Create TODO app',
      description: 'Build a simple TODO app in Flutter',
      isDone: false,
      due: DateTime(2023, 8, 15),
    ),
    Task_(
      id: '2',
      title: 'Go grocery shopping',
      description: 'Buy milk, eggs, bread',
      isDone: true,
      due: DateTime(2023, 8, 10),
    ),
    Task_(
      id: '3',
      title: 'Pay electric bill',
      description: 'Pay online or in-person before due date',
      isDone: false,
      due: DateTime(2023, 8, 20),
    )
  ];
  test('should get a list of todos from the repository', () async {
    when(repository.getTasks()).thenAnswer((_)  => Stream.value(tTodoList));
    final result = viewAllTasks();
    expect(result, emits(tTodoList));
    verify(repository.getTasks());
    verifyNoMoreInteractions(repository);
  });
}
