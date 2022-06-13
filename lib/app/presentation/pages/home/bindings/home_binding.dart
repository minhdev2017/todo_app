import 'package:get/get.dart';
import 'package:todo_app/app/data/datasources/todo_local_db.dart';
import 'package:todo_app/app/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_complete_controller.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_imcomplete_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoLocalDataSource>(
        () => TodoLocalDataSourceImpl(database: Get.find()));
    Get.lazyPut<TodoRepositoryImpl>(
        () => TodoRepositoryImpl(localDataSource: Get.find()));
    Get.lazyPut(() => HomeController(Get.find<TodoRepositoryImpl>()));
    Get.lazyPut(() => HomeCompleteController(Get.find<TodoRepositoryImpl>()));
    Get.lazyPut(() => HomeImCompleteController(Get.find<TodoRepositoryImpl>()));
  }
}
