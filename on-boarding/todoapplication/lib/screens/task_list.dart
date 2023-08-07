import 'package:flutter/material.dart';
import 'package:todoapplication/main.dart';

import '../Task.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 40.0),
        child: Column(children: [
          Container(
              width: 236,
              height: 242,
              child:
                  Image.asset('assets/images/tasklist.png', fit: BoxFit.cover)),
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
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return TaskTile(task: Task(
                    title: 'Task Name',
                    description: 'Buy a new phone',
                    due: DateTime.now()));
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, TodoPageRoutes.addTask);
                },
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 64, vertical: 16)),
                child: const Text('create task',
                    style: TextStyle(color: Colors.white, fontSize: 19)),
              ))
        ]),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  TaskTile({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, TodoPageRoutes.taskDetail, arguments: {
              'task': task
            });
          },
          child: Container(
            height: 60,
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
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              task.title[0],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          width: 40,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: 60,
                          child: Text(
                            task.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        height: 60,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.due.toIso8601String(),
                              style: const  TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8)),
                              child:
                                  Expanded(child: Container(width: 6)),
                            )
                          ],
                        )),
                  ]),
            ),
          ),
        ));
  }
}

