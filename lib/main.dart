import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  runApp(const MyApp());
}

late Database database;
Future initDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = '${databasesPath}demo.db';

  // open the database
  database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(TodoModel.CREATE_TABLE);
  });
  Get.put<Database>(database);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
