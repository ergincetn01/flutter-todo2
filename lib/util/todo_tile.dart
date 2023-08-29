import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final bool isChild;
  VoidCallback createChild;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  TodoTile({
    super.key,
    required this.taskName,
    required this.isChild,
    required this.createChild,
    required this.isCompleted,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: isChild ? const EdgeInsets.only(left: 10.0) : EdgeInsets.zero,
        child: Container(
          padding: isChild ? const EdgeInsets.only(left: 20) : EdgeInsets.zero,
          decoration: BoxDecoration(
              color: isCompleted ? Colors.red : Colors.blue[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 2.0, color: Colors.black)),
          child: ListTile(
            title: Text(
              taskName),
              trailing: isChild
                  ? null
                  : IconButton(
                      onPressed: createChild,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.green,
                        
                      )),
              leading: Checkbox(
                onChanged: onChanged,
                value: isCompleted,
              ),
            ),
          ),
        );
  }
}
