class DocModel {
  String? docId;
  TodoItemModel? todo;
  DocModel({this.docId, this.todo});
}

class TodoItemModel {
  String? userId;
  String? todoId;
  String? detail;
  String? deadline;
  bool isDone;

  TodoItemModel({
    this.userId,
    this.todoId,
    this.detail,
    this.deadline,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "todo_id": todoId,
      "detail": detail,
      "deadline": deadline,
      "is_done": isDone,
    };
  }

  factory TodoItemModel.fromJson(Map<String, dynamic> json) {
    return TodoItemModel(
      userId: json['user_id'],
      todoId: json['todo_id'],
      detail: json['detail'],
      deadline: json['deadline'],
      isDone: json['is_done'],
    );
  }

  TodoItemModel copyWith({
    String? detail,
    String? deadline,
    bool? isDone,
  }) =>
      TodoItemModel(
        userId: userId,
        todoId: todoId,
        detail: detail ?? this.detail,
        deadline: deadline ?? this.deadline,
        isDone: isDone ?? this.isDone,
      );
  TodoItemModel changeIsDone() => copyWith(isDone: !isDone);
}
