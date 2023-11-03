import 'package:bloc_example/bloc/todo_bloc/todo_cubit.dart';
import 'package:bloc_example/repositories/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoAddScreen extends StatefulWidget {
  const TodoAddScreen({super.key});

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  final TodoRepository todoRepository = TodoRepository();
  final TextEditingController todoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

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
                InkWell(
                  onTap: () async {
                    BlocProvider.of<TodoCubit>(context).addTodo(
                      detail: todoController.text,
                      deadline: dateController.text,
                    );

                    Future.delayed(Duration(milliseconds: 200), () {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration:
                          BoxDecoration(color: Colors.indigoAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )),
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
