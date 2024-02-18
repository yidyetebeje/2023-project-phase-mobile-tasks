import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';

class TaskModel extends Task_ {
  const TaskModel({
    required String id,
    required String title,
    required String description,
    bool isDone = false,
    required DateTime due,
  }) : super(
          id: id,
          title: title,
          description: description,
          isDone: isDone,
          due: due,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
      due: DateTime.parse(json['due']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'due': due.toIso8601String(),
    };
  }
}