import 'package:dartz/dartz.dart';
import 'package:todo_app/app/code/error/failure.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoModel>>> fetchTodo({int? complete});
  Future<Either<Failure, TodoModel>> findTodo(String name);

  Future<Either<Failure, int>> addTodo(TodoModel todo);
  Future<Either<Failure, bool>> updateTodo(TodoModel todo);
  Future<Either<Failure, bool>> deleteTodo(TodoModel todo);
}
