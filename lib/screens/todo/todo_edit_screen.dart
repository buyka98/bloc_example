import 'package:bloc_example/bloc/todo_bloc/todo_cubit.dart';
import 'package:bloc_example/models/todo_item_model.dart';
import 'package:bloc_example/repositories/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoEditScreen extends StatefulWidget {
  final TodoItemModel todo;
  final String? docId;
  const TodoEditScreen({super.key, required this.todo, required this.docId});

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  final TodoRepository todoRepository = TodoRepository();
  final TextEditingController todoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    todoController.text = widget.todo.detail ?? "";
    if (widget.todo.deadline != null) {
      dateController.text = widget.todo.deadline!.substring(0, 10);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add new item"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: todoController,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Description',
                  ),
                ),
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Deadline',
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 3650)),
                    ).then((value) => setState(() {
                          if (value != null) {
                            dateController.text = value.toString().substring(0, 10);
                          }
                        }));
                  },
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        BlocProvider.of<TodoCubit>(context).deleteTodo(widget.docId);
                        // todo handle delete
                        // todoRepository.deleteTodo(docId: widget.docId);
                        Future.delayed(Duration(milliseconds: 200), () {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<TodoCubit>(context).editTodo(
                            widget.docId,
                            deadline: dateController.text,
                            detail: todoController.text,
                          );
                          Future.delayed(Duration(milliseconds: 200), () {
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.indigoAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
