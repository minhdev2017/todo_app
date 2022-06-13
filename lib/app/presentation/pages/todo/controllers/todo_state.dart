import 'package:equatable/equatable.dart';
import 'package:todo_app/app/data/models/todo_model.dart';

abstract class TodoState extends Equatable {
  final List property;

  const TodoState({this.property = const []});

  @override
  List<Object?> get props => property;
}

class Empty extends TodoState {}

class Failed extends TodoState {
  final String message;

  Failed({required this.message}) : super(property: [message]);
}

class Success extends TodoState {
  final TodoModel todo;

  Success({required this.todo}) : super(property: [todo]);
}

class Error extends TodoState {
  final String message;

  Error({required this.message}) : super(property: [message]);
}
