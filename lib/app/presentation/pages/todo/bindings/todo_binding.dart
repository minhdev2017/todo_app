import 'package:get/get.dart';
import 'package:todo_app/app/data/datasources/todo_local_db.dart';
import 'package:todo_app/app/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/app/domain/repositories/todo_repository.dart';
import 'package:todo_app/app/presentation/pages/todo/controllers/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoLocalDataSource>(
        () => TodoLocalDataSourceImpl(database: Get.find()));
    Get.lazyPut<TodoRepository>(
        () => TodoRepositoryImpl(localDataSource: Get.find()));
    Get.lazyPut(() => TodoController(Get.find()));
  }
}
