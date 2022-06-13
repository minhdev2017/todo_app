import 'package:get/get.dart';
import 'package:todo_app/app/presentation/pages/home/bindings/home_binding.dart';
import 'package:todo_app/app/presentation/pages/home/views/todo_home.dart';
import 'package:todo_app/app/presentation/pages/todo/bindings/todo_binding.dart';
import 'package:todo_app/app/presentation/pages/todo/views/todo_edit.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: Routes.EDIT_TODO,
      page: () => TodoEditPage(),
      bindings: [TodoBinding()],
    )
  ];
}
