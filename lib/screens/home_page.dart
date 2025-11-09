import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _namaController = TextEditingController();
  final _todoController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tugas Week 8 - Pemrograman Mobile"),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
      ),
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Field Nama Lengkap
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 10),

              // Field Password + Toggle
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Field Tugas
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        labelText: "Masukkan tugas...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_namaController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _todoController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Semua field harus diisi!"),
                          ),
                        );
                        return;
                      }
                      await provider.setNamaLengkap(_namaController.text);
                      await provider.addTodo(_todoController.text);
                      _todoController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    child: const Text("Tambah"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (provider.namaLengkap.isNotEmpty)
                Text(
                  "Hai, ${provider.namaLengkap} 👋",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              const SizedBox(height: 10),

              // ListView tugas
              Container(
                height: 400,
                child: ListView.builder(
                  itemCount: provider.todos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(provider.todos[index]),
                        leading: const Icon(Icons.check_circle_outline),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  provider.clearData();
                  _namaController.clear();
                  _passwordController.clear();
                  _todoController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                icon: const Icon(Icons.delete),
                label: const Text("Hapus Semua Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
