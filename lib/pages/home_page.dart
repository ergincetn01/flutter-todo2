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
      db.todoList
          .add(BasicTile(title: _controller.text, isDone: false, tiles: []));
      _controller.clear();
    });

    db.updateDb();
    Navigator.pop(context);
  }

  void deleteTask(int i) {
    setState(() {
      basicTiles.removeAt(i);
    });
    db.updateDb();
  }

  void saveNestedTodo(int i) {
    setState(() {
      db.todoList[i].tiles.add((BasicTile(
          title: _nestController.text,
          isDone: false,
          tiles: [])));
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
          title: const Text("Nested List Children"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewTask, child: const Icon(Icons.add)),
        body: ListView(
          children: db.todoList.map(buildTile).toList(),
        ));
  }

//Convert this component into ListTile later

  Widget buildTile(BasicTile tile) {
    int index1 = db.todoList.indexOf(tile);
    return (ExpansionTile(
        title: Text(tile.title),
        trailing: IconButton(
          onPressed: (){
            createNestedTodo(index1);
          }, 
          icon: const Icon(Icons.add, color: Colors.green,)),
        children: tile.tiles.map((e) => buildTile(e)).toList()));
  }
}
