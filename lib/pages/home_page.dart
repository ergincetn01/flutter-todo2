import 'package:flutter/material.dart';
import 'package:todo2/data/database.dart';
import 'package:todo2/util/basic_tile.dart';
import 'package:todo2/util/modal_box.dart';
import 'package:todo2/util/nested_modal_box.dart';
import 'package:todo2/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database db = Database();

  final _controller = TextEditingController();
  final _nestController = TextEditingController();

  void createNewTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return ModalBox(
              controller: _controller,
              onSave: () {
                if (_controller.text != "") {
                  saveNewTodo();
                } else {}
              },
              onCancel: () => handleCancel());
        });
  }

  void saveNewTodo() {
    setState(() {
      db.todoList.add(
          BasicTile(title: _controller.text, isDone: false, isChild: false));
      _controller.clear();
    });

    db.updateDb();
    Navigator.pop(context);
  }

  void deleteTodo(int i) {
    setState(() {
      db.todoList.removeAt(i);
    });
    db.updateDb();
  }

  void createNestedTodo(int i) {
    showDialog(
        context: context,
        builder: (context) {
          return NestedModalBox(
              controller: _nestController,
              tileTitle: db.todoList[i].title,
              onCancel: () => handleNestedTodoCancel(),
              onSave: () {
                if (_nestController.text != "") {
                  saveNestedTodo(i);
                } else {}
              });
        });
  }

  void saveNestedTodo(int i) {
    setState(() {
      db.todoList.add((BasicTile(
          title: _nestController.text, isDone: false, isChild: true)));
      _nestController.clear();
    });
    db.updateDb();
    Navigator.pop(context);
  }

  void handleCancel() {
    Navigator.of(context).pop();
    _controller.clear();
  }

  void handleNestedTodoCancel() {
    Navigator.of(context).pop();
    _nestController.clear();
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index].isDone = !db.todoList[index].isDone;
    });
    db.updateDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text("Todo app with Children"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewTodo, child: const Icon(Icons.add)),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: db.todoList.length,
                itemBuilder: (BuildContext context, index) {
                  return TodoTile(
                    taskName: db.todoList[index].title,
                    isChild: db.todoList[index].isChild,
                    createChild: () {
                      createNestedTodo(index);
                    },
                    isCompleted: db.todoList[index].isDone,
                    onChanged: (value) => checkboxChanged(value, index),
                    deleteTask: (p0) => deleteTodo(index),
                  );
                },
              ),
            ),
          ],
        ));
  }
}


/*  --->  THESE METHODS ARE NO LONGER USED! <---
  
  Widget buildTile(BasicTile tile) {
    int index1 = db.todoList.indexOf(tile);
    return (Column(
      children: [
        Padding(
          padding: tile.isChild
              ? const EdgeInsets.only(left: 10.0)
              : EdgeInsets.zero,
          child: ListTile(
            title: Text(tile.title),
            trailing: IconButton(
                onPressed: () {
                  createNestedTodo(index1);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.green,
                )),
            leading: Checkbox(
              onChanged: (value) => checkboxChanged(value, index1),
              value: db.todoList[index1].isDone,
            ),
          ),
        ),
      ],
    ));
  }

  Widget buildNestedList(BasicTile tile) {
    int index1 = db.todoList.indexOf(tile);
    return (ListView.builder(itemBuilder: (builder, context) {
      ListTile(
        title: Text(tile.title),
        trailing: IconButton(
          onPressed: () {
            createNestedTodo(index1);
          },
          icon: const Icon(Icons.add),
        ),
      );
    }));
  }
}
*/
