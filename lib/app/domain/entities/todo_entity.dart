import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  int? id;
  String title;
  int complete;
  String content;
  int color;

  TodoEntity({
    required this.id,
    required this.title,
    required this.complete,
    required this.content,
    required this.color,
  });

  @override
  List<Object?> get props => [title, complete, content, color];
}
