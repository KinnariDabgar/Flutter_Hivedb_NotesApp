import 'package:flutter/material.dart';
import 'package:hivedb_example/adapters/todo_adapters.dart';
import 'package:hive/hive.dart';

class AddTodo extends StatefulWidget {
  final formkey = GlobalKey<FormState>();

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  var title, description;
  submitData() async {
    if (widget.formkey.currentState!.validate()) {
      Box<Todo> todobox = Hive.box<Todo>('todos');
      todobox.add(Todo(title: title, description: description));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Form(
              key: widget.formkey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Title";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Title", labelText: "Title"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter description";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Description",
                          labelText: "Description"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: submitData, child: Text("Add Todo")),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
