import 'package:equatable/equatable.dart';
import 'package:todo_app/app/data/models/todo_model.dart';

abstract class HomeState extends Equatable {
  final List property;

  const HomeState({this.property = const []});

  @override
  List<Object?> get props => property;
}

class Empty extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final List<TodoModel> todoList;

  Loaded({required this.todoList}) : super(property: [todoList]);
}

class Error extends HomeState {
  final String message;

  Error({required this.message}) : super(property: [message]);
}
