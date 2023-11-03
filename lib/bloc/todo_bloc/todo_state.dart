part of 'todo_cubit.dart';

class TodoState extends Equatable {
  final List<DocModel> todoList;
  const TodoState({this.todoList = const []});

  @override
  List<Object> get props => [todoList];
}

class TodoLoading extends TodoState {}
