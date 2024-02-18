import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String message;
  Failure({required this.message});
  @override
  List<Object> get props => [message];
}