import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_complete_controller.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_imcomplete_controller.dart';
import 'package:todo_app/app/presentation/pages/home/views/todo_all.dart';
import 'package:todo_app/app/presentation/pages/home/views/todo_complete.dart';
import 'package:todo_app/app/presentation/pages/home/views/todo_imcomplete.dart';
import 'package:todo_app/routes/app_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;

  late PageController _pageController;

  late HomeController homeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController();
    homeController = Get.find();
    print("home is: initState");
    homeController.getAllTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (index == 0) {
              homeController.getAllTodo();
            } else if (index == 1) {
              Get.find<HomeCompleteController>().getAllTodo();
            } else {
              Get.find<HomeImCompleteController>().getAllTodo();
            }
            setState(() => _selectedIndex = index);
          },
          children: <Widget>[
            TodoAllTab(),
            TodoCompleteTab(),
            TodoImCompleteTab(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text('Todo'),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            Get.toNamed(Routes.EDIT_TODO);
          },
        ),
      ],
    );
  }

  _buildBottomBar() {
    return BottomNavyBar(
      selectedIndex: _selectedIndex,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }),
      items: [
        BottomNavyBarItem(
          icon: const Icon(Icons.all_inbox),
          title: const Text('All'),
          activeColor: Colors.cyan,
        ),
        BottomNavyBarItem(
            icon: const Icon(Icons.check),
            title: const Text('Complete'),
            activeColor: Colors.blue),
        BottomNavyBarItem(
            icon: const Icon(Icons.check_box_outline_blank_outlined),
            title: const Text('InComplete'),
            activeColor: Colors.pink),
      ],
    );
  }
}
