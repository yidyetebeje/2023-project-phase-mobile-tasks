import 'package:flutter/material.dart';
import 'package:todoappwithcleanarchitecture/core/app_block_observer.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/bloc/create_task_cubit/create_task_cubit.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/create_task_page.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/onboarding.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/task_edit_page.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/task_list.dart';
import 'package:todoappwithcleanarchitecture/service_locator.dart';

import 'package:bloc/bloc.dart';

class TaskAppPageRoutes {
  static const String onBoarding = '/onBoarding';
  static const String taskDetail = '/taskDetail';
  static const String taskList = '/taskList';
  static const String addTask = '/addTask';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: TaskAppPageRoutes.onBoarding,
        routes: {
          TaskAppPageRoutes.onBoarding: (context) => const OnBoardingPage(),
          TaskAppPageRoutes.taskDetail: (context) =>
              const TaskDetailPageWithBloc(),
          TaskAppPageRoutes.addTask: (context) => AddTaskPage(
              createTaskCubit: CreateTaskCubit(createTask: locator())),
          TaskAppPageRoutes.taskList: (context) => const TaskListPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 231, 83, 54)),
          useMaterial3: true,
        ));
  }
}
