import 'package:sqflite/sqflite.dart';
import 'package:todo_app/app/data/models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> fetchTodo(int? complete);

  Future<int> addTodo(TodoModel todo);

  Future<bool> updateTodo(TodoModel todo);

  Future<bool> deleteTodo(TodoModel todo);
}

class TodoLocalDataSourceImpl extends TodoLocalDataSource {
  final Database database;
  TodoLocalDataSourceImpl({required this.database});

  @override
  Future<int> addTodo(TodoModel todo) async {
    try {
      var result = await database.insert(TodoModel.TABLE_NAME, todo.toJson());
      return result;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTodo(TodoModel todo) async {
    final res = await database
        .delete(TodoModel.TABLE_NAME, where: "id=?", whereArgs: [todo.id]);
    return res == 1;
  }

  @override
  Future<List<TodoModel>> fetchTodo(int? complete) async {
    List<Map<String, Object?>> result;
    if (complete == null) {
      result = await database.query(TodoModel.TABLE_NAME);
    } else {
      result = await database.query(TodoModel.TABLE_NAME,
          where: "complete=?", whereArgs: [complete]);
    }

    return result.map((e) => TodoModel.fromJson(e)).toList();
  }

  @override
  Future<bool> updateTodo(TodoModel todo) async {
    var result = await database.update(TodoModel.TABLE_NAME, todo.toJson(),
        where: "id=?", whereArgs: [todo.id]);
    return result == 1;
  }
}
