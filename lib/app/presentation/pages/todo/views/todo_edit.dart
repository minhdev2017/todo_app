import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/models/todo_model.dart';
import 'package:todo_app/app/presentation/pages/todo/controllers/todo_controller.dart';
import 'package:todo_app/app/presentation/pages/todo/controllers/todo_state.dart';
import 'package:todo_app/app/presentation/widgets/toggle_form_field.dart';

class TodoEditPage extends StatefulWidget {
  TodoEditPage({Key? key}) : super(key: key);

  @override
  State<TodoEditPage> createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  late Color dialogPickerColor; // Color for picker in dialog using onChanged
  late Color dialogSelectColor; //
  late TodoModel todo;
  late TodoController controller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    controller = Get.find();

    dialogPickerColor = Colors.white;
    if (Get.arguments != null) {
      todo = Get.arguments;
      dialogSelectColor = Color(todo.color);
    } else {
      dialogSelectColor = Colors.white;
      todo = TodoModel(
          title: '', content: '', color: dialogSelectColor.value, complete: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() {
            if (controller.nTState.value is Success) {
              todo = (controller.nTState.value as Success).todo;
              return const Text("Todo Edit");
            }
            return Text(todo.id == null ? "Add new Todo" : "Todo Edit");
          }),
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    initialValue: todo.title,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'Please input least 5 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      todo.title = value ?? '';
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Content'),
                    initialValue: todo.content,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'Please input least 5 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      todo.content = value ?? '';
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(() {
                    if (controller.nTState.value is Success ||
                        todo.id != null) {
                      return Row(
                        children: [
                          const Text('Completed'),
                          ToggleFormField(
                            initialValue: todo.complete == 1,
                            onSaved: (bool? value) {
                              todo.complete = value! ? 1 : 0;
                            },
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Color:"),
                      InkWell(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: dialogSelectColor, border: Border.all()),
                        ),
                        onTap: () async {
                          final Color newColor = await showColorPickerDialog(
                            // The dialog needs a context, we pass it in.
                            context,
                            // We use the dialogSelectColor, as its starting color.
                            dialogSelectColor,
                            title: Text('ColorPicker',
                                style: Theme.of(context).textTheme.headline6),
                            width: 40,
                            height: 40,
                            spacing: 0,
                            runSpacing: 0,
                            borderRadius: 0,
                            wheelDiameter: 165,
                            enableOpacity: true,
                            showColorCode: true,
                            colorCodeHasColor: true,

                            constraints: const BoxConstraints(
                                minHeight: 480, minWidth: 320, maxWidth: 320),
                          );
                          // We update the dialogSelectColor, to the returned result
                          // color. If the dialog was dismissed it actually returns
                          // the color we started with. The extra update for that
                          // below does not really matter, but if you want you can
                          // check if they are equal and skip the update below.
                          todo.color = newColor.value;
                          setState(() {
                            dialogSelectColor = newColor;
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }

            _formKey.currentState!.save();
            if (todo.id == null) {
              controller.addTodo(todo);
            } else {
              controller.saveTodo(todo);
            }
          },
        ));
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyText2,
      colorCodePrefixStyle: Theme.of(context).textTheme.caption,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }
}
