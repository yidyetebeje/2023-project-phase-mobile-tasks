import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/delete_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/update_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/bloc/task_bloc.dart';
import 'package:todoappwithcleanarchitecture/main.dart';
import 'package:todoappwithcleanarchitecture/service_locator.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TaskBloc(
            viewAllTasks: locator<ViewAllTasks>(),
            updateTask: locator<UpdateTask>(),
            deleteTask: locator<DeleteTask>()
            )
          ..add(const TaskSubscriptionRequested()),
        child: const TaskList());
  }
}

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
          Widget child = const  Center(child: CircularProgressIndicator.adaptive());
          if (state.status == TaskStatus.loading) {
            child = const Center(child: CircularProgressIndicator());
          }
          if (state.status == TaskStatus.failure) {
            child = const Center(child: Text('Something went wrong'));
          }
          if (state.status == TaskStatus.success) {
            if (state.tasks.isEmpty) {
              child = const Text(
                "No item available",
                style: TextStyle(fontSize: 24.0),
              );
            }
            child = ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                Task_ task = state.tasks[index];
                return Dismissible(key: Key(task.id), 
                onDismissed: (direction) {
                // Remove the item from the data source.
                context.read<TaskBloc>().add(TaskDeleted(task: task));
                // Then show a snackbar.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${task.title} dismissed')));
                },
                background: Container(color: Colors.red, child: const Icon(Icons.delete),),
                child: 
                  TaskTile(task: task, onToggle: (bool) => context.read<TaskBloc>().add(TaskCompletionToggled(task: task)))
                );
              },
            );
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 12.0,20.0, 40.0),
            child: Column(children: [
              Container(
                  width: 236,
                  height: 242,
                  child: Image.asset('assets/images/tasklist.png',
                      fit: BoxFit.cover)),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Task list',
                      style: TextStyle(
                          color: Color.fromARGB(255, 231, 83, 54),
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ),
              ),
              Expanded(child: child),

            ]),
          );
        }),
    floatingActionButton:
    Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: FilledButton(
          onPressed: () {
            Navigator.pushNamed(context, TaskAppPageRoutes.addTask);
          },
          style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 64, vertical: 16)),
          child: const Text('create task',
              style: TextStyle(color: Colors.white, fontSize: 19)),
        )),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Task_ task;
  final  onToggle;
  TaskTile({required this.task, required this.onToggle}) : super(key: Key(task.id));
  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMMM d, y');
    final today = DateTime.now();
            final tomorrow = today.add(Duration(days: 1));
            final isToday = task.due.year == today.year &&
                task.due.month == today.month &&
                task.due.day == today.day;
            final isTomorrow = task.due.year == tomorrow.year &&
                task.due.month == tomorrow.month &&
                task.due.day == tomorrow.day;
            final dueDateText = isToday
                ? 'Today'
                : isTomorrow
                    ? 'Tomorrow'
                    : formatter.format(task.due);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, TaskAppPageRoutes.taskDetail, arguments: {'task': task});
          },
          child: Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: (check)=>onToggle(check),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: task.isDone ? TextDecoration.lineThrough : null,
                            ),
                      ),
                      Text(
                        dueDateText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}