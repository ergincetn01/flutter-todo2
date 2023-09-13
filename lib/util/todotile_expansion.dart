import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/util/basic_tile.dart';
import 'package:todo2/util/todo_tile.dart';

class TodoTileExpansion extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final tiles;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  const TodoTileExpansion({
    super.key,
    required this.taskName,
    required this.isCompleted,
    required this.onChanged,
    this.tiles,
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
          // child: ExpansionTile(
          //   title: Text(
          //     taskName,
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold,
          //       decoration: isCompleted
          //         ? TextDecoration.lineThrough
          //         : TextDecoration.none),
          //   ),
          //   leading:  Checkbox(
          //     onChanged: onChanged,
          //     value: isCompleted),
          //     children: tiles.map()
          //   ),
            )
            ),
      
    );
  }

  Widget buildTile(BasicTile tile){
    if(tile.tiles.isEmpty){
      return ListTile(
        contentPadding: const EdgeInsets.only(left: 16),
        title: Text(tile.title));
    }
    else {
      return ExpansionTile(
        title: Text(tile.title),
        children: tile.tiles.map((tile) => buildTile(tile)).toList());
    }
  }
  
}







            // ListTile(
            //   title: Text(
            //     taskName,
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //       decoration: isCompleted
            //         ? TextDecoration.lineThrough
            //         : TextDecoration.none),
            //   ),
            //   leading: Checkbox(
            //     onChanged: onChanged,
            //     value: isCompleted),
            // ),
