import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  List<String> _todos = [];

  List<String> get todos => _todos;

  void addTodo(String text) {
    if (text.isNotEmpty) {
      _todos.add(text);
      notifyListeners(); // update UI
    }
  }
}
