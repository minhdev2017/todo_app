import 'package:todo_app/app/presentation/pages/home/controllers/home_controller.dart';

class HomeImCompleteController extends HomeController {
  HomeImCompleteController(super.repositoryImpl);

  @override
  void onInit() {
    super.onInit();
    complete = 0;
  }
}
