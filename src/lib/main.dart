import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My TodoList',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 238, 91, 0),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ' Todo List '),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todoItems = [];

  void _createTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';

        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              newTask = value;
            },
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  todoItems.add(value);
                });
                Navigator.pop(context);
              }
            },
            decoration: const InputDecoration(
              hintText: 'Enter a task',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newTask.isNotEmpty) {
                  setState(() {
                    todoItems.add(newTask);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: const Color.fromARGB(255, 39, 40, 39),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          final task = todoItems[index];

          return Dismissible(
            key: Key(task),
            onDismissed: (_) {
              setState(() {
                todoItems.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Task "$task" deleted'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: ListTile(
              title: Text(task),
              textColor: const Color.fromARGB(255, 255, 255, 255),
              trailing: const Icon(Icons.check_circle),
              onTap: () => _deleteTask(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
