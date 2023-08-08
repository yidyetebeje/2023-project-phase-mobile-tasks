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
  // equitable
  @override
  List<Object?> get props => [title, description, isDone, due, id];
}