import 'package:bloc_example/bloc/todo_bloc/todo_cubit.dart';
import 'package:bloc_example/models/todo_item_model.dart';
import 'package:bloc_example/repositories/todo_repository.dart';
import 'package:bloc_example/screens/todo/todo_add_screen.dart';
import 'package:bloc_example/screens/todo/todo_edit_screen.dart';
import 'package:bloc_example/screens/todo/widgets/todo_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoRepository todoRepository = TodoRepository();
  TodoCubit todoCubit = TodoCubit();

  @override
  void initState() {
    todoCubit.getTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => todoCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text("To do "),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                      value: todoCubit,
                      child: TodoAddScreen(),
                    )));
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
          child: blocBuilder(),
        ),
      ),
    );
  }

  Widget blocBuilder() {
    return BlocBuilder(
      bloc: todoCubit,
      builder: (BuildContext context, TodoState state) {
        if (state is TodoLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: state.todoList.length,
              itemBuilder: (context, int i) {
                return TodoItem(
                  todo: state.todoList[i].todo!,
                  docId: state.todoList[i].docId,
                  handleEdit: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                                value: todoCubit,
                                child: TodoEditScreen(
                                  todo: state.todoList[i].todo!,
                                  docId: state.todoList[i].docId,
                                ),
                              )),
                    );
                  },
                );
              });
        }
      },
    );
  }
}
