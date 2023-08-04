import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Create new task',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
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
          ),
          const SizedBox(height: 20),
          MyTextField.named(
              label: 'Due data',
              hintText: 'due date',
              iconButton: IconButton(
                  icon: Icon(Icons.calendar_month), onPressed: () {})),
          const SizedBox(height: 20),
          MyTextField.named(
              label: 'Description', hintText: 'detail description'),
          SizedBox(
            height: 100,
          ),
          FilledButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Add task'),
              ))
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String label;
  final String hintText;
  IconButton? iconButton;
  MyTextField.named(
      {required this.label,
      this.iconButton,
      super.key,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(label,
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
            child: TextField(
                decoration: InputDecoration(
                    suffixIcon: iconButton,
                    suffixIconColor: Theme.of(context).colorScheme.primary,
                    hintText: hintText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none))),
          ),
        ],
      ),
    );
  }
}
