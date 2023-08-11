import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/entities/task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/domain/usecases/create_task.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/bloc/create_task_cubit/create_task_cubit.dart';
import 'package:todoappwithcleanarchitecture/main.dart';
import 'package:todoappwithcleanarchitecture/service_locator.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime? _dueDate;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskCubit(createTask: locator<CreateTask>()),
      child: Scaffold(
        appBar: AppBar(
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
        body: BlocBuilder<CreateTaskCubit, CreateTaskState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Create new task',
                          style:
                              Theme.of(context).textTheme.headlineLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )),
                      // line spacer
                      const SizedBox(height: 20),
                      Divider(height: 10),
                      const SizedBox(height: 20),
                      // text field
                      MyTextField.named(
                        label: 'Main task name',
                        hintText: 'task name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _titleController.text = value;
                          });
                        },
                        textController: _titleController,
                      ),
                      const SizedBox(height: 20),
                      DateTimePickerFormField(
                        label: 'Due date',
                        hintText: 'Select a due date',
                        initialValue: _dueDate,
                        validator: (value) {
                          if (_dueDate == null) {
                            return 'Please select a due date';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _dueDate = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      MyTextField.named(
                          label: 'Description',
                          hintText: 'detail description',
                          onChanged: (value) {
                            setState(() {
                              _descriptionController.text = value;
                            });
                          },
                          textController: _descriptionController),
                      SizedBox(
                        height: 100,
                      ),
                      FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {

                              context.read<CreateTaskCubit>().createTask(Task_(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    due: _dueDate ?? DateTime.now(),
                                    isDone: false,
                                    id: const Uuid().v4(),
                                  ));
                                  Navigator.pushNamed(context, TaskAppPageRoutes.taskList);
                                   ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('task added successfully')));
                            }
                          },

                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Add task'),
                          ))
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

class MyTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final ValueChanged<String>? onChanged;
  IconButton? iconButton;

  String? valueText;
  Icon? suffixIcon;
  String? Function(dynamic value)? validator;
  TextEditingController textController;
  Key? key;
  void Function()? onTap;
  MyTextField.named({
    required this.label,
    this.iconButton,
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.valueText,
    this.validator,
    this.onChanged,
    required this.textController,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              label,
              style: const TextStyle(
                color: Color.fromARGB(255, 231, 83, 54),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextFormField(
              onTap: onTap,
              validator: validator,
              controller: textController,
              // onChanged: onChanged,
              decoration: InputDecoration(
                suffixIcon: iconButton,
                suffixIconColor: Theme.of(context).colorScheme.primary,
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateTimePickerFormField extends StatefulWidget {
  final String label;
  final String? hintText;
  final DateTime? initialValue;
  final FormFieldValidator<DateTime>? validator;
  final FormFieldSetter<DateTime>? onSaved;

  const DateTimePickerFormField({
    Key? key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  _DateTimePickerFormFieldState createState() =>
      _DateTimePickerFormFieldState();
}

class _DateTimePickerFormFieldState extends State<DateTimePickerFormField> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue ?? DateTime.now();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(picked.year, picked.month, picked.day,
              pickedTime.hour, pickedTime.minute);
          widget.onSaved!(_selectedDate);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      onSaved: widget.onSaved,
      builder: (state) {
        return GestureDetector(
          onTap: _selectDate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(widget.label,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 231, 83, 54),
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ]),
                child: InputDecorator(
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    errorText: state.errorText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate != null
                            ? DateFormat.yMd().add_jm().format(_selectedDate)
                            : '',
                        style: TextStyle(
                          color: _selectedDate != null
                              ? Theme.of(context).textTheme.bodyText1!.color
                              : Theme.of(context).disabledColor,
                        ),
                      ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
