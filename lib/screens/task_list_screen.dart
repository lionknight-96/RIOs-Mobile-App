import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/task_service.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser!;
    final tasks = TaskService().getTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List"),
        actions: [
          ElevatedButton(
            onPressed: () {
              AuthService().logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text("Log Out"),
          )
        ],
      ),
      body: Column(
        children: [
          /// Profile
          Container(
            color: Colors.black87,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(user.image),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ID - ${user.id}",
                        style: const TextStyle(color: Colors.white)),
                    Text("Name - ${user.name}",
                        style: const TextStyle(color: Colors.white)),
                    const Text("Status - Working",
                        style: TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, i) => TaskCard(task: tasks[i]),
            ),
          )
        ],
      ),
    );
  }
}