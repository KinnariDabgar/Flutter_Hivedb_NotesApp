import 'package:hive/hive.dart';
part 'todo_adapters.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  var title;

  @HiveField(1)
  var description;

  Todo({this.title, this.description});
}
