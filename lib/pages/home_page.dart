import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
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
  // final _myBox = Hive.box('mybox');

  Database db = Database();

  final _controller = TextEditingController();
  final _nestController = TextEditingController();

  void saveNewTodo() {
    setState(() {
      db.todoList.add(
          BasicTile(title: _controller.text, isDone: false, isChild: false));
      _controller.clear();
    });

    db.updateDb();
    Navigator.pop(context);
  }

  void deleteTask(int i) {
    setState(() {
      db.todoList.removeAt(i);
    });
    db.updateDb();
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
void handleCancel(){
  Navigator.of(context).pop();
  _controller.clear();
}
  void createNestedTodo(int i) {
    showDialog(
        context: context,
        builder: (context) {
          return NestedModalBox(
              //nested dialog box component is reuquired (add new task to ${todoList[i].title})
              controller: _nestController,
              tileTitle: db.todoList[i].title,
              onCancel: () => handleCancel(),
              onSave: () {
                saveNestedTodo(i);
              });
        });
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return ModalBox(
              controller: _controller,
              onSave: saveNewTodo,
              onCancel: () => handleCancel());
        });
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
          centerTitle: true,
          title: const Text("Todo app with Children"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewTask, child: const Icon(Icons.add)),
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
                     deleteTask: (p0)=>
                      deleteTask(index),
                     );
                },
              ),
            ),
          ],
        ));
  }

//hivedb id atama (1dedn başalyarak sıralı şekilde artacak)
//child ise "child-$id" şeklinde bir değer tutacak

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
