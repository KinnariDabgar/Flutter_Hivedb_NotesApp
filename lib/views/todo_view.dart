import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedb_example/views/add_todo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivedb_example/adapters/todo_adapters.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddTodo()));
            }),
        appBar: AppBar(
          title: Center(child: Text("Hive_Todo_App")),
        ),
        body: ValueListenableBuilder(
            valueListenable: Hive.box<Todo>('todos').listenable(),
            builder: (context, Box<Todo> box, _) {
              if (box.values.isEmpty) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(100, 250, 100, 100),
                    child: Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Text("No Data Found")
                        ],
                      ),
                    ),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    Todo? todo = box.getAt(index);
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                      child: Card(
                        color: Colors.lightGreen[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 0, 4),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  todo!.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  todo.description,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: IconButton(
                                  tooltip: "Delete",
                                  onPressed: () async {
                                    await box.deleteAt(index);
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.black,
                                  )),
                              trailing: IconButton(
                                  tooltip: "Edit",
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.black,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                    // return ListTile(
                    //   onLongPress: () async {
                    //     await box.deleteAt(index);
                    //   },
                    //   title: Text(todo!.title),
                    //   subtitle: Text(todo.description),
                    // );
                  });
            }));
  }
}
