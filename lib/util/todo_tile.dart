import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  const TodoTile({
    super.key,
    required this.taskName,
    required this.isCompleted,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, left: 3, right: 3, bottom: 3),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
            borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10)),
            onPressed: deleteTask,
            icon: Icons.delete,
            autoClose: true,
            backgroundColor: Colors.red,
            )
          ]),
      child: Container(
      decoration: BoxDecoration(
        color: isCompleted ? Colors.red : Colors.green[400],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10)),
            ),
        child: ListTile(
          title: Text(
            taskName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none),
          ),
          leading: Checkbox(
            onChanged: onChanged,
            value: isCompleted),
        ),
      ),
      ),
    );
  }
}
