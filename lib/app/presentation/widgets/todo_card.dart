import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:todo_app/routes/app_pages.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todo;
  final HomeController controller;

  const TodoCard({Key? key, required this.todo, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(todo.color), width: 2.0)),
      child: Row(
        children: <Widget>[
          Container(
            width: 40.0,
            height: 80.0,
            child: todo.complete == 1
                ? IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      controller.updateTodoStatus(todo.copy(complete: 0));
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.check_box_outline_blank),
                    onPressed: () {
                      controller.updateTodoStatus(todo.copy(complete: 1));
                    },
                  ),
          ),
          Expanded(
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  todo.title,
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
              onTap: () {
                Get.toNamed(Routes.EDIT_TODO, arguments: todo);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Get.defaultDialog(
                  middleText: "Are you sure delete it?",
                  textConfirm: "Yes",
                  textCancel: "Cancel",
                  onConfirm: () {
                    Get.back();
                    controller.deleteTodo(todo);
                  });
            },
          )
        ],
      ),
    );
  }
}
