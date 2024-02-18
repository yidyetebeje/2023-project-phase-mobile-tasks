import 'package:flutter_test/flutter_test.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/models/task_model.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';

void main() {
  final tTaskModel = TaskModel(
    id: '1',
    title: 'Test Task',
    description: 'This is a test task',
    isDone: false,
    due: DateTime.now(),
  );

  final tJson = {
    'id': '1',
    'title': 'Test Task',
    'description': 'This is a test task',
    'isDone': false,
    'due': tTaskModel.due.toIso8601String(),
  };

  test(
    'should be a subclass of Task entity',
    () async {
      // assert
      expect(tTaskModel, isA<Task_>());
    },
  );

  test(
    'should correctly convert from JSON to TaskModel',
    () async {
      final Map<String, dynamic> jsonMap = tJson;
      final result = TaskModel.fromJson(jsonMap);
      expect(result, tTaskModel);
    },
  );

  test(
    'should correctly convert to JSON from TaskModel',
    () async {
      final result = tTaskModel.toJson();
      expect(result, tJson);
    },
  );
}