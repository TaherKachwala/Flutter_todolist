class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return[
      // ToDo(id: '01', todoText: 'Morning Excercise', isDone: true),
      // ToDo(id: '02', todoText: 'Morning Excercise', isDone: true),
      // ToDo(id: '03', todoText: 'Morning Excercise', ),
      // ToDo(id: '04', todoText: 'Morning Excercise', ),
      ToDo(id: '01', todoText: 'Pay for the Parking on 10th.', ),
      ToDo(id: '02', todoText: 'Study Hard!.', ),
    ];
  }
}