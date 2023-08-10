import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/datasources/task_api.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/datasources/task_local_data_source.dart';
import 'package:todoappwithcleanarchitecture/features/todo/data/repositories/task_repository_imp.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/repositories/task_repository.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/create_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/delete_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/update_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/view_task.dart';
final locator = GetIt.instance;

Future<void> setup()async {
  final sharedPreference = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreference);
  locator.registerSingleton<TaskApi>(TaskLocalDataSource(sharedPreferences:locator()));
  locator.registerSingleton<TaskRepository>(TaskRepositoryImpl(locator()));
  locator.registerFactory(()=> ViewAllTasks(locator()));
  locator.registerFactory(() => ViewTask(locator()));
  locator.registerFactory(() => UpdateTask(locator()));
  locator.registerFactory(() => CreateTask(locator()));
  locator.registerFactory(() => DeleteTask(locator()));

}