import 'package:dartz/dartz.dart';
import 'package:todo_app/app/code/error/exception_handler.dart';
import 'package:todo_app/app/code/error/failure.dart';
import 'package:todo_app/app/data/datasources/todo_local_db.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoLocalDataSource localDataSource;
  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, int>> addTodo(TodoModel todo) async {
    try {
      var result = await localDataSource.addTodo(todo);
      return Right(result);
    } catch (ex) {
      return Left(handleException(ex as Exception));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTodo(TodoModel todo) async {
    try {
      var result = await localDataSource.deleteTodo(todo);
      return Right(result);
    } catch (ex) {
      return Left(handleException(ex as Exception));
    }
  }

  @override
  Future<Either<Failure, TodoModel>> findTodo(String name) {
    // TODO: implement findTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TodoModel>>> fetchTodo({int? complete}) async {
    try {
      var result = await localDataSource.fetchTodo(complete);
      return Right(result);
    } catch (ex) {
      return Left(handleException(ex as Exception));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTodo(TodoModel todo) async {
    try {
      var result = await localDataSource.updateTodo(todo);
      return Right(result);
    } catch (ex) {
      return Left(handleException(ex as Exception));
    }
  }
}
