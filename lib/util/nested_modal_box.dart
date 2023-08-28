import 'package:flutter/material.dart';
import 'package:todo2/util/task_button.dart';


class NestedModalBox extends StatelessWidget {
  final controller;
  final String tileTitle;
  VoidCallback onSave;
  VoidCallback onCancel;
  NestedModalBox(
      {super.key,
      required this.controller,
      required this.tileTitle,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add task to $tileTitle"),
      backgroundColor: Colors.white,
      content: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                style: const TextStyle(fontSize: 20),
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add a new task..."),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TaskButton(
                    text: "Save",
                    onPressed: () {
                    onSave();
                    },
                    ),
                  const SizedBox(width: 8),
                  TaskButton(
                      text: "Cancel",
                      onPressed: () {
                        onCancel();
                      })
                ],
              )
            ],
          )),
    );
  }
}
