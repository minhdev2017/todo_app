import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/app/code/error/exception_handler.dart';
import 'package:todo_app/app/code/error/exceptions.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_state.dart';

import 'home_controller_test.mocks.dart';

@GenerateMocks([TodoRepositoryImpl])
void main() {
  late HomeController controller;
  late MockTodoRepositoryImpl mockTodoRepositoryImpl;

  final todoModel = TodoModel(
      id: 1,
      title: "Todo from json",
      complete: 1,
      color: Colors.white.value,
      content: "Todo content from json");

  setUp(() {
    mockTodoRepositoryImpl = MockTodoRepositoryImpl();

    controller = HomeController(mockTodoRepositoryImpl);
  });

  test('initialState should be Empty', () {
    // assert
    expect(controller.nTState.value, equals(Empty()));
  });
  group('fetch Todo', () {
    void mockFetchTodoError() {
      when(mockTodoRepositoryImpl.fetchTodo(complete: anyNamed('complete')))
          .thenAnswer((_) async => Left(handleException(Exception())));
    }

    void mockFetchTodoSuccess() {
      when(mockTodoRepositoryImpl.fetchTodo(complete: anyNamed('complete')))
          .thenAnswer((_) async => Right([todoModel]));
    }

    test('Should call fetch todo return success', () async {
      mockFetchTodoSuccess();
      await controller.getAllTodo();
      expect(controller.nTState.value, equals(Loaded(todoList: [todoModel])));
    });

    test('Should call fetch todo return error', () async {
      mockFetchTodoError();
      await controller.getAllTodo();
      expect(controller.nTState.value, equals(Error(message: "Exception")));
    });
  });
}
