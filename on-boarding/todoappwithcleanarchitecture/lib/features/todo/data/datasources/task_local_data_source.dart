import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoappwithcleanarchitecture/core/failure/failure.dart';
import 'package:todoappwithcleanarchitecture/core/failure/not_found.dart';
import 'package:todoappwithcleanarchitecture/core/failure/storage_failure.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/datasources/task_api.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/models/task_model.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';

class TaskLocalDataSource extends TaskApi {
  TaskLocalDataSource({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences {
    _init();
  }
  final _taskStreamController = BehaviorSubject<List<TaskModel>>.seeded(const []);
  final SharedPreferences _sharedPreferences;
  @visibleForTesting
  static const kTodosCollectionKey = '__todos_collection_key__';
  String? _getValue(String key) => _sharedPreferences.getString(key);
  Future<void> _setValue(String key, String value) =>
      _sharedPreferences.setString(key, value);
  Future<void> _init() async {
    final taskJson = _getValue(kTodosCollectionKey);
    if (taskJson != null) {
      final tasks = List<Map<String, dynamic>>.from(
        json.decode(taskJson) as List<dynamic>,
      ).map((jsonMap) => TaskModel.fromJson(jsonMap)).toList();
      _taskStreamController.add(tasks);
    } else {
      _taskStreamController.add(const []);
    }
  }

  @override
  Stream<List<Task_>> getTasks() => _taskStreamController.asBroadcastStream();

  @override
  Future<Either<Failure, Task_>> createTask(Task_ task) {
    TaskModel taskModel = TaskModel(description: task.description, title: task.title, id: task.id, isDone: task.isDone, due: task.due);
    final tasks = [..._taskStreamController.value, taskModel];
    _taskStreamController.add(tasks);
    try {
      final taskJson = json.encode(tasks);
      _setValue(kTodosCollectionKey, taskJson);
      return Future.value(Right(task));
    } catch (e) {
      print(e);
      return Future.value(Left(StorageFailure()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(String id) {
    final tasks = [..._taskStreamController.value];
    final index = tasks.indexWhere((task) => task.id == id);
    if (index >= 0) {
      tasks.removeAt(index);
      try {
        final taskJson = json.encode(tasks);
        _setValue(kTodosCollectionKey, taskJson);
        _taskStreamController.add(tasks);
        return Future.value(const Right(unit));
      } catch (e) {
        return Future.value(Left(StorageFailure()));
      }
    } else {
      return Future.value(Left(NotFound()));
    }
  }

  @override
  Future<Either<Failure, Task_>> getTaskById(String id) {
    final tasks = [..._taskStreamController.value];
    final index = tasks.indexWhere((task) => task.id == id);
    if (index >= 0) {
      final task = tasks[index];
      return Future.value(Right(task));
    } else {
      return Future.value(Left(NotFound()));
    }
  }

  @override
  Future<Either<Failure, Task_>> updateTask(Task_ task) {
    final tasks = [..._taskStreamController.value];
    final index = tasks.indexWhere((task) => task.id == task.id);
    if (index >= 0) {
      tasks[index] = task as TaskModel;
      _taskStreamController.add(tasks);
      try {
        final taskJson = json.encode(tasks);
        _setValue(kTodosCollectionKey, taskJson);
        return Future.value(Right(task));
      } catch (e) {
        return Future.value(Left(StorageFailure()));
      }
    } else {
      return Future.value(Left(NotFound()));
    }
  }
}
