// Mocks generated by Mockito 5.2.0 from annotations
// in todo_app/test/data/repositories/todo_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_app/app/data/datasources/todo_local_db.dart' as _i2;
import 'package:todo_app/app/data/models/todo_model.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [TodoLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoLocalDataSource extends _i1.Mock
    implements _i2.TodoLocalDataSource {
  MockTodoLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.TodoModel>> fetchTodo(int? complete) =>
      (super.noSuchMethod(Invocation.method(#fetchTodo, [complete]),
              returnValue: Future<List<_i4.TodoModel>>.value(<_i4.TodoModel>[]))
          as _i3.Future<List<_i4.TodoModel>>);
  @override
  _i3.Future<int> addTodo(_i4.TodoModel? todo) =>
      (super.noSuchMethod(Invocation.method(#addTodo, [todo]),
          returnValue: Future<int>.value(0)) as _i3.Future<int>);
  @override
  _i3.Future<bool> updateTodo(_i4.TodoModel? todo) =>
      (super.noSuchMethod(Invocation.method(#updateTodo, [todo]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<bool> deleteTodo(_i4.TodoModel? todo) =>
      (super.noSuchMethod(Invocation.method(#deleteTodo, [todo]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}
