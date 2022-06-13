import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/app/data/datasources/todo_local_db.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database database;
  late TodoLocalDataSourceImpl localDatasource;
  late TodoModel todoModel;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    localDatasource = TodoLocalDataSourceImpl(database: database);
    database.execute(TodoModel.CREATE_TABLE);
    todoModel = TodoModel(
        id: 1,
        title: "Todo from json",
        complete: 1,
        color: Colors.white.value,
        content: "Todo content from json");
  });

  tearDown(() {
    database.close();
  });

  group('Todo action', () {
    test('Should call save todo with correct values', () async {
      await localDatasource.addTodo(todoModel);
      expect(await database.query(TodoModel.TABLE_NAME), [todoModel.toJson()]);
    });

    test('Should call update todo with correct values', () async {
      await localDatasource.addTodo(todoModel);
      var todoCopy = todoModel.copy(id: todoModel.id, title: "title updated");
      await localDatasource.updateTodo(todoCopy);

      expect(await database.query(TodoModel.TABLE_NAME), [todoCopy.toJson()]);
    });

    test('Should call delte todo with correct values', () async {
      await localDatasource.addTodo(todoModel);
      await localDatasource.deleteTodo(todoModel);

      expect(await database.query(TodoModel.TABLE_NAME), []);
    });
  });

  group('fetchTodo', () {
    test('Should call fetch Todo with all', () async {
      await localDatasource.addTodo(todoModel);
      var result = await localDatasource.fetchTodo(null);
      expect(result, [todoModel]);
    });
    test('Should call fetch Todo with complete', () async {
      await localDatasource.addTodo(todoModel);
      var result = await localDatasource.fetchTodo(1);
      expect(result, [todoModel]);
    });

    test('Should call fetch Todo with imcomplete', () async {
      await localDatasource.addTodo(todoModel);
      var result = await localDatasource.fetchTodo(0);
      expect(result, []);
    });
  });
}
