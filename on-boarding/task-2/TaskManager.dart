import 'dart:io';

class Task {
  String? title;
  String? description;
  DateTime? due;
  bool? status;

  Task(this.title, this.description, this.due, this.status);

  void printTask() {
    print("Title: $title");
    print("Description: $description");
    print("Due: $due");
    print("Status: $status");
  }

  void setTitle(String? title) => this.title = title;
  String? get getTitle => this.title;

  void setDescription(String? description) => this.description = description;
  String? get getDescription => this.description;

  void setDue(DateTime? due) => this.due = due;
  DateTime? get getDue => this.due;

  void toggleStatus() => this.status = !this.status!;
  bool? get getStatus => this.status;
}

class TaskManager {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
  }

  void removeTask(int index) {
    tasks.removeAt(index);
  }

  void printTasks() {
    for (int i = 0; i < tasks.length; i++) {
      print("Task $i");
      tasks[i].printTask();
    }
  }

  void printTask(int index) {
    tasks[index].printTask();
  }

  void toggleTask(int index) {
    tasks[index].toggleStatus();
  }

  void editTask(int index) {
    print("What do you want to edit?");
    print("1. Title");
    print("2. Description");
    print("3. Due");
    print("4. Status");
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        print("Enter new title: ");
        String? title = stdin.readLineSync();
        tasks[index].setTitle(title);
        break;
      case 2:
        print("Enter new description: ");
        String? description = stdin.readLineSync();
        tasks[index].setDescription(description);
        break;
      case 3:
        print("Enter new due: ");
        DateTime? due = DateTime.parse(stdin.readLineSync()!);
        tasks[index].setDue(due);
        break;
      case 4:
        tasks[index].toggleStatus();
        break;
      default:
        print("Invalid choice");
    }
  }

  List<Task> get getCompletedTasks {
    List<Task> completedTasks = this.tasks.where((element) => element.getStatus!).toList();
    return completedTasks;
  }

  List<Task> get getPendingTasks {
    List<Task> incompletedTasks = this.tasks.where((element) => !element.getStatus!).toList();
    return incompletedTasks;
  }
}

class TaskApplication {
  TaskManager taskManager = TaskManager();

  void run() {
    while (true) {
      print("What do you want to do?");
      print("1. Add task");
      print("2. Remove task");
      print("3. Print tasks");
      print("4. Print task");
      print("5. Toggle task");
      print("6. Edit task");
      print("7. Print completed tasks");
      print("8. Print pending tasks");
      print("9. Exit");
      int choice = int.parse(stdin.readLineSync()!);
      switch (choice) {
        case 1:
          print("Enter title: ");
          String? title = stdin.readLineSync();
          print("Enter description: ");
          String? description = stdin.readLineSync();
          print("Enter due (YYYY-MM-DD):");
          DateTime? due = DateTime.parse(stdin.readLineSync()!);
          print("Enter status: ");
          bool? status = bool.fromEnvironment(stdin.readLineSync()!);
          Task task = Task(title, description, due, status);
          taskManager.addTask(task);
          break;
        case 2:
          print("Enter index: ");
          int index = int.parse(stdin.readLineSync()!);
          taskManager.removeTask(index);
          break;
        case 3:
          taskManager.printTasks();
          break;
        case 4:
          print("Enter index: ");
          int index = int.parse(stdin.readLineSync()!);
          taskManager.printTask(index);
          break;
        case 5:
          print("Enter index: ");
          int index = int.parse(stdin.readLineSync()!);
          taskManager.toggleTask(index);
          break;
        case 6:
          print("Enter index: ");
          int index = int.parse(stdin.readLineSync()!);
          taskManager.editTask(index);
          break;
        case 7:
          var completedTask = taskManager.getCompletedTasks;
          completedTask.forEach((element) {
            element.printTask();
          });
          break;
        case 8:
          var pendingTask = taskManager.getPendingTasks;
            pendingTask.forEach((element) {
                element.printTask();
            });
          break;
        case 9:
          return;
        default:
          print("Invalid choice");
      }
    }
  }
}

void main() {
  TaskApplication taskApplication = TaskApplication();
  taskApplication.run();
}