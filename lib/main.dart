import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:todo2/pages/welcome_screen.dart";
import "package:todo2/util/basic_tile.dart";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BasicTileAdapter());
  await Hive.openBox('todo2box');
  
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(title: "ToDo App"),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
