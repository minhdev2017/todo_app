import 'package:todo_app/app/presentation/pages/home/controllers/home_controller.dart';

class HomeCompleteController extends HomeController {
  HomeCompleteController(super.repositoryImpl);

  @override
  void onInit() {
    super.onInit();
    complete = 1;
  }
}
