import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_complete_controller.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_imcomplete_controller.dart';
import 'package:todo_app/app/presentation/pages/todo/controllers/todo_state.dart';

class TodoController extends GetxController {
  final TodoRepositoryImpl _repositoryImpl;
  TodoController(this._repositoryImpl);

  Rx<TodoState> nTState = Rx(Empty());

  Future addTodo(TodoModel todo) async {
    final todoIDEither = await _repositoryImpl.addTodo(todo);

    await todoIDEither.fold(
      (failure) {
        if (kDebugMode) {
          print("error is ${failure.message}");
        }
        Fluttertoast.showToast(
            msg: failure.message ?? "error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
      },
      (results) async {
        if (results == 0) {
          Fluttertoast.showToast(
              msg: "Todo added failure",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
          nTState.value = Failed(message: "Todo added failure");
        } else {
          Fluttertoast.showToast(
              msg: "Todo added successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
          nTState.value = Success(todo: todo.copy(id: results));
          Get.find<HomeController>().getAllTodo();
          Get.find<HomeCompleteController>().getAllTodo();
          Get.find<HomeImCompleteController>().getAllTodo();
        }
      },
    );
  }

  Future saveTodo(TodoModel todo) async {
    final resultEither = await _repositoryImpl.updateTodo(todo);

    await resultEither.fold(
      (failure) {
        if (kDebugMode) {
          print("error is ${failure.message}");
        }
        Fluttertoast.showToast(
            msg: failure.message ?? "error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
      },
      (results) async {
        if (!results) {
          Fluttertoast.showToast(
              msg: "Todo updated failure",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
          nTState.value = Failed(message: "Todo updated failure");
        } else {
          Fluttertoast.showToast(
              msg: "Todo updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
          nTState.value = Success(todo: todo);
          Get.find<HomeController>().getAllTodo();
          Get.find<HomeCompleteController>().getAllTodo();
          Get.find<HomeImCompleteController>().getAllTodo();
        }
      },
    );
  }
}
