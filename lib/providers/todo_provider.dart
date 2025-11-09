import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider with ChangeNotifier {
  List<String> _todos = [];
  String _namaLengkap = "";

  List<String> get todos => _todos;
  String get namaLengkap => _namaLengkap;

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _namaLengkap = prefs.getString('namaLengkap') ?? "";
    _todos = prefs.getStringList('todos') ?? [];
    notifyListeners();
  }

  Future<void> addTodo(String text) async {
    if (text.isNotEmpty) {
      _todos.add(text);
      notifyListeners();
      await _saveData();
    }
  }

  Future<void> setNamaLengkap(String nama) async {
    _namaLengkap = nama;
    notifyListeners();
    await _saveData();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('namaLengkap', _namaLengkap);
    await prefs.setStringList('todos', _todos);
  }

  void clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _namaLengkap = "";
    _todos = [];
    notifyListeners();
  }
}
