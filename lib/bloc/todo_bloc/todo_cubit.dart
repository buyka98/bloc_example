import 'package:bloc/bloc.dart';
import 'package:bloc_example/models/todo_item_model.dart';
import 'package:bloc_example/repositories/todo_repository.dart';
import 'package:equatable/equatable.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState());

  final TodoRepository _todoRepository = TodoRepository();

  Future<void> getTodo({bool showLoading = true}) async {
    if (showLoading) {
      emit(TodoLoading());
    }

    var res = await _todoRepository.getTodo();
    List<DocModel> todoList = [];
    for (var doc in res.docs) {
      todoList.add(DocModel(
        docId: doc.id,
        todo: TodoItemModel.fromJson(doc.data()),
      ));
    }
    todoList.sort((a, b) => a.todo!.isDone ? 1 : 0);
    emit(TodoState(todoList: todoList));
  }

  Future<void> deleteTodo(String? docId) async {
    emit(TodoLoading());

    _todoRepository.deleteTodo(docId: docId);
    getTodo();
  }

  Future<void> checkTodo(String? docId, bool isDone) async {
    _todoRepository.checkTodo(docId: docId, isDone: isDone);
    getTodo(showLoading: false);
  }

  Future<void> editTodo(String? docId, {String? detail, String? deadline}) async {
    _todoRepository.editTodo(docId: docId, detail: detail, deadline: deadline);
    getTodo();
  }

  Future<void> addTodo({String? detail, String? deadline}) async {
    _todoRepository.addTodo(detail: detail, deadline: deadline);
    getTodo();
  }
}
