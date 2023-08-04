import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key});

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: 307,
                height: 307,
                child: Image.asset('assets/images/shoppinglist.png',
                    fit: BoxFit.cover),
              ),
              TaskDescriptionItem(
                  title: 'Task Name', description: 'Buy a new phone'),
              SizedBox(height: 20,),
              TaskDescriptionItem(
                  title: 'Task Description', description: 'First I have to animate the logo and prototyping my design. It’s very important.'),
              SizedBox(height: 20,),
              TaskDescriptionItem(
                  title: 'Task Date', description: 'April. 29, 2023'),
            ],
          ),
        ));
  }
}

class TaskDescriptionItem extends StatelessWidget {
  final title;
  final description;
  TaskDescriptionItem({super.key, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Color(0xFFF1EEEE),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  this.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                )))
      ],
    );
  }
}
