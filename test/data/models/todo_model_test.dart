import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/app/data/models/todo_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  List<TodoModel> listModel = [];
  final todoModel = TodoModel(
      id: 1,
      title: "Todo from json",
      complete: 1,
      color: Colors.white.value,
      content: "Todo content from json");

  group("fromJson", () {
    test("should be a subclass of Todo entity", () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("todo.json"));

      final result = TodoModel.fromJson(jsonMap);

      expect(result, todoModel);
    });
  });

  group("toJson", () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = todoModel.toJson();
        // assert
        final expectedJsonMap = {
          "id": 1,
          "title": "Todo from json",
          "complete": 1,
          "content": "Todo content from json",
          "color": Colors.white.value,
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
