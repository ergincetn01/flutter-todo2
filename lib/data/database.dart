import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo2/util/basic_tile.dart';

class Database {
  List<BasicTile> todoList = [];

  final _myBox = Hive.box('mybox');

  void insertTodoItem(BasicTile tile) {
    todoList.add(tile);
  }

  void createInitialData() {
    todoList = [
      const BasicTile(title: "dvDDGGGG", isDone: false, tiles: []),
      const BasicTile(title: "ev işleri", isDone: false, tiles: [
        BasicTile(title: "ev işleri1", isDone: false, tiles: []),
        BasicTile(title: "ev işleri2", isDone: false, tiles: [])
      ])
    ];
    print("init...");
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
    print("load data...");
  }

  void updateDb() {
    _myBox.put("TODOLIST", todoList);
    print("db update...");
  }
}
