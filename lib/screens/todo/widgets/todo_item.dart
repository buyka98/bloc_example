import 'package:bloc_example/bloc/todo_bloc/todo_cubit.dart';
import 'package:bloc_example/models/todo_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final TodoItemModel todo;
  final String? docId;
  final Function handleEdit;

  const TodoItem({
    super.key,
    required this.todo,
    required this.docId,
    required this.handleEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<TodoCubit>(context).checkTodo(docId, todo.isDone);
              },
              icon: Icon(todo.isDone ? Icons.check_circle : Icons.circle_outlined),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: InkWell(
            onTap: () => handleEdit(),
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(todo.detail ?? ""),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month),
                      Text(
                        DateFormat.yMMMd().format(todo.deadline == null ? DateTime.now() : DateTime.parse(todo.deadline!)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
