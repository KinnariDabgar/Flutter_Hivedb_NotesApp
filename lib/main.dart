import 'package:flutter/material.dart';
import 'package:hivedb_example/adapters/todo_adapters.dart';
import 'package:hivedb_example/splashscreen.dart';
import 'package:hivedb_example/views/todo_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo_Hive',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
