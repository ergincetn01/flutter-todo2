import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo2/data/database.dart';
import 'package:todo2/util/basic_tile.dart';
import 'package:todo2/util/modal_box.dart';
import 'package:todo2/util/nested_modal_box.dart';

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

  void createNestedTodo(int i) {
    showDialog(
        context: context,
        builder: (context) {
          return NestedModalBox(
              //nested dialog box component is reuquired (add new task to ${todoList[i].title})
              controller: _nestController,
              tileTitle: db.todoList[i].title,
              onCancel: () => Navigator.of(context).pop(),
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
              onCancel: () => Navigator.of(context).pop());
        });
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
                return Padding(
                  padding: db.todoList[index].isChild
                    ? const EdgeInsets.only(left: 15.0)
                    : EdgeInsets.zero,
                  child: ListTile(
                  title: Text(db.todoList[index].title),
                  trailing: IconButton(
                  onPressed: () {
                    createNestedTodo(index);
                  },
                  icon: const Icon(Icons.add,
                    color: Colors.green,
                  )),
                  ),
                );
              },
            ),
          ),
        ],
      ));
  }

//hivedb id atama (1dedn başalyarak sıralı şekilde artacak)
//child ise "child-$id" şeklinde bir değer tutacak

// Widget buildList(BasicTile tile){

//   return(ListView.builder(itemBuilder: (context, index) {
//       ListTile(
//         leading: Icon(Icons.arrow_right),
//         title: Text(tile.title));
//   },));
// }

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
