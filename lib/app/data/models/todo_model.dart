import 'package:todo_app/app/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel(
      {int? id,
      required title,
      required complete,
      required content,
      required color})
      : super(
            id: id,
            title: title,
            complete: complete,
            content: content,
            color: color);

  factory TodoModel.fromJson(Map<String, dynamic> jsonMap) {
    return TodoModel(
      id: (jsonMap['id'] as num).toInt(),
      title: jsonMap['title'],
      complete: (jsonMap['complete'] as num).toInt(),
      content: jsonMap['content'],
      color: (jsonMap['color'] as num).toInt(),
    );
  }

  TodoModel copy(
      {int? id, String? title, int? complete, String? content, String? color}) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      complete: complete ?? this.complete,
      content: content ?? this.content,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'complete': complete,
      'content': content,
      'color': color,
    };
  }

  static const String TABLE_NAME = "todo_table";

  static const String CREATE_TABLE =
      "CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY, title TEXT, complete INTEGER, content TEXT, color INTEGER)";
  static const String DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";
}
