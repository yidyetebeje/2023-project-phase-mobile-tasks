import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/update_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/bloc/edit_task_cubit/edit_task_cubit.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/create_task_page.dart';
import 'package:todoappwithcleanarchitecture/main.dart';
import 'package:todoappwithcleanarchitecture/service_locator.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({Key? key}) : super(key: key);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  DateTime? _updateDueDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController(); // Added scroll controller

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;

    var task = args['task'] as Task_;
    var titleController = TextEditingController(text: task.title);
    var descriptionController = TextEditingController(text: task.description);
    _updateDueDate = task.due;

    return BlocProvider(
      create: (context) => EditTaskCubit(updateTask: locator<UpdateTask>()),
      child: Scaffold(
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
        body: BlocBuilder<EditTaskCubit, EditTaskState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: scrollController, // Added scroll controller
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 307,
                        height: 307,
                        child: Image.asset(
                          'assets/images/shoppinglist.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      MyTextField.named(
                        label: "title",
                        hintText: "Ui/UX design",
                        textController: titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DateTimePickerFormField(
                        label: 'Due date',
                        hintText: 'Select a due date',
                        initialValue: _updateDueDate,
                        validator: (value) {
                          if (_updateDueDate == null) {
                            return 'Please select a due date';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _updateDueDate = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField.named(
                        label: "title",
                        hintText: "Ui/UX design",
                        textController: descriptionController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<EditTaskCubit>().updateTask(
                              Task_(
                                title: titleController.text,
                                description: descriptionController.text,
                                due: _updateDueDate ?? DateTime.now(),
                                isDone: task.isDone,
                                id: task.id,
                              ),
                            );
                            Navigator.pushNamed(
                                context, TaskAppPageRoutes.taskList);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('task edited successfully'),
                              ),
                            );
                          }
                        },

                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('edit task'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TaskDescriptionItem extends StatelessWidget {
  final String title;
  final String description;
  const TaskDescriptionItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            color: const Color(0xFFF1EEEE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ],
    );
  }
}