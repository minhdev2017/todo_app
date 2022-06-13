import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/presentation/pages/home/controllers/home_controller.dart';
import 'package:todo_app/app/presentation/widgets/loading_widget.dart';

import 'package:todo_app/main.dart';
import 'package:todo_app/routes/app_pages.dart';

void main() {
  late Database database;
  late TodoModel todoModel;
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    database.execute(TodoModel.CREATE_TABLE);
    todoModel = TodoModel(
        id: null,
        title: "Todo from json",
        complete: 1,
        color: Colors.white.value,
        content: "Todo content from json");
    Get.put<Database>(database);
  });

  tearDown(() {
    database.close();
  });
  testWidgets('app test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await database.insert(TodoModel.TABLE_NAME, todoModel.toJson());
      await tester.pumpWidget(MyApp());
      //await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text("Todo is Empty"), findsOneWidget);
      expect(find.byType(LoadingWidget), findsNothing);
      expect(find.byType(ListView), findsNothing);

      expect(find.byType(LoadingWidget), findsNothing);

      await Get.find<HomeController>().getAllTodo();

      await tester.pumpAndSettle();
      expect(find.text("Todo from json"), findsOneWidget);
      expect(find.text("Todo is Empty"), findsNothing);
      expect(find.byType(ListView), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(Get.currentRoute, Routes.EDIT_TODO);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.save));
      await tester.pump();

      expect(find.text("Please input least 5 characters"), findsNWidgets(2));

      await tester.enterText(find.byType(TextFormField).first, "todo 1");
      await tester.enterText(find.byType(TextFormField).last, "todo content 1");
      await tester.tap(find.byIcon(Icons.save));
      await tester.pump();
      expect(find.text("Please input least 5 characters"), findsNothing);
    });
  });
}
