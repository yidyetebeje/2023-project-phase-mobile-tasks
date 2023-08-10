import 'package:equatable/equatable.dart';

class Task_ extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime due;

  Task_({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.due,
  });

  Task_ copyWith({
    String? title,
    String? description,
    bool? isDone,
    DateTime? due,
    String? id,
  }) {
    return Task_(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      due: due ?? this.due,
      id: id ?? this.id,
    );
  }
  factory Task_.fromJson(Map<String, dynamic> json) {
    return Task_(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
      due: DateTime.parse(json['due']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'due': due.toIso8601String(),
    };
  }
  // equitable
  @override
  List<Object?> get props => [title, description, isDone, due, id];
}