import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_complete_controller.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_state.dart';
import 'package:todo_app/app/presentation/widgets/todo_card.dart';

import '../../../widgets/loading_widget.dart';

class TodoCompleteTab extends GetView<HomeCompleteController> {
  TodoCompleteTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (_) {
          Widget child = Container();
          print("state is: ${controller.nTState}");
          final state = controller.nTState.value;
          if (state is Empty) {
            child = const Text("Todo is Empty");
          } else if (state is Loading) {
            child = const LoadingWidget();
          } else if (state is Loaded) {
            child = _buildTodoList(state.todoList);
          } else if (state is Error) {
            child = Text(state.message);
          }
          return Container(
            alignment: Alignment.center,
            child: child,
          );
        });
  }

  _buildTodoList(List<TodoModel> todoList) {
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: ((context, index) => TodoCard(
              todo: todoList[index],
              controller: controller,
            )));
  }
}
