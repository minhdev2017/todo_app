import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/app/code/error/exception_handler.dart';
import 'package:todo_app/app/code/error/exceptions.dart';
import 'package:todo_app/app/code/error/failure.dart';
import 'package:todo_app/app/data/datasources/todo_local_db.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/data/repositories/todo_repository_impl.dart';

import 'todo_repository_test.mocks.dart';

@GenerateMocks([TodoLocalDataSource])
void main() {
  late MockTodoLocalDataSource dataSourceMockSpy;
  late TodoRepositoryImpl todoRepositoryImpl;
  final todoModel = TodoModel(
      id: 1,
      title: "Todo from json",
      complete: 1,
      color: Colors.white.value,
      content: "Todo content from json");

  setUp(() {
    dataSourceMockSpy = MockTodoLocalDataSource();
    todoRepositoryImpl = TodoRepositoryImpl(localDataSource: dataSourceMockSpy);
  });

  group('saveTodo', () {
    void mockSaveTodoError() {
      when(dataSourceMockSpy.addTodo(todoModel))
          .thenThrow(ServerUnknownException());
    }

    void mockSaveTodoSuccess() {
      when(dataSourceMockSpy.addTodo(todoModel))
          .thenAnswer((_) => Future.value(1));
    }

    test('Should call save todo with correct values', () async {
      mockSaveTodoSuccess();
      await todoRepositoryImpl.addTodo(todoModel);
      verify(dataSourceMockSpy.addTodo(todoModel));
    });

    test('Should throw if save todo throws', () async {
      mockSaveTodoError();

      final result = await todoRepositoryImpl.addTodo(todoModel);

      expect(
          result,
          equals(Left(ServerUnknownFailure(
              message: ServerUnknownException().toString()))));
    });
  });
}
