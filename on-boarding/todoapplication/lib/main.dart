import 'package:flutter/material.dart';
import 'package:todoapplication/screens/create_task.dart';
import 'package:todoapplication/screens/onboarding.dart';
import 'package:todoapplication/screens/task_detail.dart';
import 'package:todoapplication/screens/task_list.dart';

void main() {
  runApp(const MyApp());
}
class TodoPageRoutes {
  static const String onBoarding = '/onBoarding';
  static const String taskDetail = '/taskDetail';
  static const String taskList = '/taskList';
  static const String addTask = '/addTask';
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: TodoPageRoutes.onBoarding,
        routes: {
          TodoPageRoutes.onBoarding: (context) => const OnBoardingPage(),
          TodoPageRoutes.taskDetail: (context) => const TaskDetailPage(),
          TodoPageRoutes.addTask: (context) => const AddTaskPage(),
          TodoPageRoutes.taskList: (context) => const TaskListPage(),
        },
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 231, 83, 54)),
          useMaterial3: true,
        )
    );
  }
}




