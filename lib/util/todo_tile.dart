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
        padding: isChild
            ? const EdgeInsets.only(left: 20.0, top: 3, right: 3)
            : const EdgeInsets.only(top: 5, left: 3, right: 3),
        child: Slidable(
          endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: deleteTask,
                  icon: Icons.delete,
                  autoClose: true,
                  backgroundColor: Colors.red,
                )
              ]),
          child: Container(
            padding:
                isChild ? const EdgeInsets.only(left: 20) : EdgeInsets.zero,
            decoration: BoxDecoration(
                color: isCompleted ? Colors.red : Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.0, color: Colors.black)),
            child: ListTile(
              title: Text(
                taskName,
                style: TextStyle(
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              trailing: isChild
                  ? null
                  : IconButton(
                    color: Colors.white,
                      onPressed: createChild,
                      icon: const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 2, 20, 48),
                      )),
              leading: Checkbox(
                onChanged: onChanged,
                value: isCompleted,
              ),
            ),
          ),
        ));
  }
}
