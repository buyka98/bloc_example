import 'package:bloc_example/models/todo_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class TodoRepository extends ChangeNotifier {
  // final firestore = ;
  final collection = FirebaseFirestore.instance.collection("todo");
  final auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> displayTodo() {
    return collection.snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getTodo() {
    return collection.get();
  }

  void addTodo({String? detail, String? deadline}) {
    TodoItemModel todo = TodoItemModel(
      userId: auth.currentUser?.uid,
      todoId: collection.doc().id,
      deadline: deadline,
      detail: detail,
    );
    collection.add(todo.toJson());
  }

  void editTodo({required String? docId, String? detail, String? deadline}) {
    collection.doc(docId).update({
      "detail": detail,
      "deadline": deadline,
    });
  }

  void checkTodo({required String? docId, required bool isDone}) {
    collection.doc(docId).update({"is_done": !isDone});
    notifyListeners();
  }

  void deleteTodo({required String? docId}) {
    collection.doc(docId).delete();
  }
}
