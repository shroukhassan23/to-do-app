class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    //constructor with parameters to create the task
    required this.id,
    required this.todoText,
    this.isDone = false,
  });
}
