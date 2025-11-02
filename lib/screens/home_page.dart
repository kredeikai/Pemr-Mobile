import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do App (Provider)"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Masukkan tugas...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    todoProvider.addTodo(_controller.text);
                    _controller.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                  child: const Text("Tambah"),
                )
              ],
            ),
            const SizedBox(height: 20),

            // ListView untuk menampilkan data
            Expanded(
              child: ListView.builder(
                itemCount: todoProvider.todos.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(todoProvider.todos[index]),
                      leading: const Icon(Icons.check_circle_outline),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
