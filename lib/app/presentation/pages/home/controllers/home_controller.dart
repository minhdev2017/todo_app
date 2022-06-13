import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_state.dart';

class HomeController extends GetxController {
  final TodoRepositoryImpl _repositoryImpl;
  HomeController(this._repositoryImpl);

  Rx<HomeState> nTState = Rx(Empty());

  int? complete;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future getAllTodo() async {
    nTState.value = Loading();
    final todosEither = await _repositoryImpl.fetchTodo(complete: complete);
    update();
    //await Future.delayed(const Duration(seconds: 1));
    await todosEither.fold(
      (failure) {
        if (kDebugMode) {
          print("error is ${failure.message}");
        }
        nTState.value = Error(message: failure.message ?? "");
      },
      (results) async {
        if (results.isEmpty) {
          nTState.value = Empty();
        } else {
          nTState.value = Loaded(todoList: results);
        }
        update();
      },
    );
  }

  void updateTodoStatus(TodoModel todo) async {
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
        } else {
          Fluttertoast.showToast(
              msg: "Todo updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
          var todoList = (nTState.value as Loaded).todoList;
          var editTodo =
              todoList.firstWhere((element) => element.id == todo.id);
          editTodo.complete = todo.complete;
          nTState.value = Loaded(todoList: todoList);
          update();
        }
      },
    );
  }

  void deleteTodo(TodoModel todo) async {
    final resultEither = await _repositoryImpl.deleteTodo(todo);

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
              msg: "Todo deleted failure",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        } else {
          Fluttertoast.showToast(
              msg: "Todo deleted successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
          var todoList = (nTState.value as Loaded).todoList;
          //nTState.value = Loading();
          todoList.removeWhere((element) => element.id == todo.id);
          nTState.value = Loaded(todoList: todoList);
          update();
        }
      },
    );
  }
}
