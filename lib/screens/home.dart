// import 'dart:ffi';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:todolist/constants/colors.dart';
import 'package:todolist/widgets/timedate.dart';
import 'package:todolist/widgets/todo_item.dart';
import 'package:todolist/model/todo.dart';

class Home extends StatefulWidget{
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo =[];
  final _todoController = TextEditingController();  // to wirte text in textBox //

@override
  void initState() {
    // TODO: implement initState
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assests/boy.png'),  
          ),
        )
      ],),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,        //date
          children: [
            // DatePickerTxt(),
            // SchduleBtn(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search,color: tdBlack,size: 20,),
                  prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: tdGrey)
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50,bottom:20),
                    child: Text('All ToDos',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                  ),
                  for (ToDo todo in _foundToDo.reversed)
                  ToDoItem(todo: todo,
                  onToDoChange: _handleToDoChange,
                  onDeleteItem: _deleteToDoItem,
                  ),
                ],
              ),
            ),
            Align(alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          // Expanded(child: Container(
          //   margin: EdgeInsets.only(
          //     bottom: 20,
          //     right: 20,
          //     left: 20,
          //   ),
          //   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     // boxShadow: const BoxShadow(
          //     //   color: colors.grey,
          //     //   offset: Offset(0.0,0.0),
          //     //   blurRadius: 10.0,
          //     //   spreadRadius: 0.0,
          //     // ),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: TextField(
          //     controller: _todoController,
          //     decoration: InputDecoration(
          //       hintText: 'Add New Iteam.',
          //       contentPadding: const EdgeInsets.symmetric(horizontal:5),
          //       border: InputBorder.none
          //     ),
          //   ),
          // )),
          Container(
            width: 440,
            margin: 
            EdgeInsets.only(
              bottom: 20,
              right: 20,
            ),
            child: ElevatedButton(
              child: Text('ADD ITEMS',style: TextStyle(fontSize: 22),),
              onPressed: () async {
                final result = await showDialog(context: context, builder: (context) {
                  return AddDialog(symptoms: _todoController, clinic: "", patientName: "", height: 12, weight: 12, clinicId: "", addToDoItem: () { _addToDoItem (_todoController.text); },);
                } );
                // print(result);
                _addToDoItem(result);  // to write Text which is given by user //  
              },
              style: ElevatedButton.styleFrom(
                primary: tdBlue,
                minimumSize: Size(60, 60),
                elevation: 10,
              )
            ),
          )
        ],
      ),)
          ],
        ),
      ),
    ); 
  }
  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }
  // create a fuction to write text //
  void _addToDoItem(String todo) {
    setState(() {
      todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), 
      todoText: todo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword){
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty) {
      results = todoList;
    } else{
      results = todoList.where((item) => item.todoText!.toLowerCase().contains
      (enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
} 
// class DatePickerTxt extends StatefulWidget{
//   const DatePickerTxt ({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<DatePickerTxt> createState() => _DatePickerTxtState();
  
//   static void showDateTimePicker(BuildContext context, {required bool showTileActions, required Function(dynamic date) onChanged, required Null Function(dynamic date) onConfirm}) {}
// }

// class _DatePickerTxtState extends State<DatePickerTxt>{
//   var scheduleTime;

//   @override
//   Widget build(BuildContext) {
//     return TextButton(
//       onPressed: () {
//         DatePickerTxt.showDateTimePicker(
//           context,
//           showTileActions: true,
//           onChanged: (date) => scheduleTime = date,
//           onConfirm: (date) {},
//         );
//       },
//       child: const Text(
//         'Select Date Time',
//         style: TextStyle(color: Colors.blue),
//       )
//     );
//   }
// }

// class SchduleBtn extends StatelessWidget{
//   var scheduleTime;

//   SchduleBtn ({
//     Key? key,
//   }) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: const Text('Schedule Notifications'),
//       onPressed: () {
//         debugPrint('Notification Scheduled for $scheduleTime');
//         NotificationService().scheduleNotification(
//           title: 'Scheduled Notification',
//           Body: '$scheduleTime',
//           scheduledNoificationDateTime: scheduleTime);
//       },
//     );
//   }
// }

// class NotificationService {
//   void scheduleNotification({required String title, required String Body, required scheduledNoificationDateTime}) {}
// }


// Future showNotification(
//   {int id=0, String? title, String? body, String? payLoad}) async {
//     var notificationPlugin;
//     return notificationPlugin.show(
//       id, title, body, await NotificationDetails(),
//     );
//   }
  
//   NotificationDetails() {
//   }