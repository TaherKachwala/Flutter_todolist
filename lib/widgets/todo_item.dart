import 'package:flutter/material.dart';
import 'package:todolist/constants/colors.dart';
import 'package:todolist/model/todo.dart';

class ToDoItem extends StatefulWidget {
  final ToDo todo; 
  final onToDoChange; 
  final onDeleteItem;
  const ToDoItem({super.key, required this.todo, this.onToDoChange, this.onDeleteItem});

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child:
    ListTile(
      onTap: () {
        widget.onToDoChange(widget.todo);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20, vertical: 5
      ),
      tileColor: Colors.white,
      leading: Icon( widget.todo.isDone? Icons.check_box : Icons.check_box_outline_blank,
      color: tdBlue,),
      title: Text(widget.todo.todoText! ,style: TextStyle(fontSize: 16,color: tdBlack,
      decoration: widget.todo.isDone? TextDecoration.lineThrough: null),),
      trailing: Container(
        padding: EdgeInsets.all(0) ,
        // margin: EdgeInsets.symmetric(vertical: 12),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: tdRed, 
          borderRadius: BorderRadius.circular(5),
        ),
        child: IconButton(
          color: Colors.white,
          iconSize: 18,
          icon: Icon(Icons.delete),
          onPressed: () {
            widget.onDeleteItem(widget.todo.id);
          },
        ),
      ),
    )
    ,);
  }
}