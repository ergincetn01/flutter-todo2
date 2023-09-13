import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo2/data/database.dart';
import 'package:todo2/util/basic_tile.dart';
import 'package:todo2/util/modal_box.dart';
import 'package:todo2/util/todo_tile.dart';


class TodoListPage extends StatefulWidget {
  const TodoListPage({
    super.key,
  });

  @override
  State<TodoListPage> createState() => _TodoListState();
}

class _TodoListState extends State<TodoListPage> {
  final _myBox = Hive.box('todo2box');

  Database db = Database();
  final int selectedIndex = 0;
  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index].isDone = !db.todoList[index].isDone;
    });
    db.updateDb();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add(BasicTile(title: _controller.text, isDone: false));
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDb();
  }

  void deleteTask(
    int index,
  ) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDb();
  }

  SnackBar deletePrompt(int i) {
    return (SnackBar(
      content: Text("${db.todoList[i].title} deleted"),
      action: SnackBarAction(
        label: 'Cancel',
        onPressed: () {},
      ),
      duration: const Duration(seconds: 2),
    ));
  }

  final snackBar = SnackBar(
    content: const Text('Cannot be empty!'),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Cancel',
      onPressed: () {},
    ),
  );

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return ModalBox(
          controller: _controller,
          onSave: () {
            if (_controller.text != "") {
              saveNewTask();
            } 
            else {
              ScaffoldMessenger.of(context).
                showSnackBar(snackBar);
            }
          },
          onCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
          }
        );
      }
    );
  }

  void setSelected(int i) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.checklist_rounded,
                color: Colors.white,
              ),
              Text(
                'My Todos',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewTask, child: const Icon(Icons.add)),
        body: db.todoList.isEmpty
            ? const Center(child: Text("You haven't added any todos!"))
            : ListView.builder(
                itemCount: db.todoList.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                      taskName: db.todoList[index].title,
                      isCompleted: db.todoList[index].isDone,
                      deleteTask: (context) {
                        deleteTask(index);
                        // deletePrompt(index);
                      },
                      onChanged: (value) => checkboxChanged(value, index));
                }));
  }
}
