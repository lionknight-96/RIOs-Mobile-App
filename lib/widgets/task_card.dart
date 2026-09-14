import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/auth_service.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool expanded = false;

  Color statusColor(String status) {
    switch (status) {
      case "Available":
        return Colors.red;
      case "In Progress":
        return Colors.blue;
      case "Completed":
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  Color buttonColor(String status) {
    if (status == "Available") {
      return const Color(0xFF3B3B3B);
    } else {
      return const Color(0xFFA6A6A6);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.task;
    final user = AuthService.currentUser!;
    final lastName = user.name.split(" ").last;

    /// ✅ CORRECT PERMISSION LOGIC
    bool isAssignedToAnyone = t.assignedTo == "Anyone";
    bool isAssignedToUser = t.assignedTo == lastName;

    bool canPress = false;

    if (t.status == "Available") {
      canPress = isAssignedToAnyone || isAssignedToUser;
    } else if (t.status == "In Progress") {
      canPress = t.assignedUserId == user.id;
    } else {
      canPress = false;
    }

    /// ✅ "(You)" DISPLAY FIX
    final isYou =
        t.assignedTo != "Anyone" && t.assignedTo == lastName;

    Widget assignText() {
      return RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            const TextSpan(text: "Assign to - "),
            TextSpan(text: t.assignedTo),
            if (isYou)
              const TextSpan(
                text: " (You)",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title + Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(t.time,
                    style: const TextStyle(fontSize: 12)),
              ],
            ),

            const SizedBox(height: 6),

            assignText(),
            Text("Location - ${t.location}"),

            Text(
              "Status - ${t.status}",
              style: TextStyle(
                color: statusColor(t.status),
              ),
            ),

            /// Expanded details
            if (expanded) ...[
              const SizedBox(height: 10),
              Text(t.description),
            ],

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Details
                Row(
                  children: [
                    const Text("Details"),
                    IconButton(
                      icon: Icon(
                        expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                      onPressed: () {
                        setState(() => expanded = !expanded);
                      },
                    ),
                  ],
                ),

                /// Action Button
                ElevatedButton(
                  onPressed: canPress
                      ? () {
                    setState(() {
                      if (t.status == "Available") {
                        t.status = "In Progress";
                        t.assignedUserId = user.id;
                        t.assignedTo = lastName;
                      } else if (t.status == "In Progress") {
                        t.status = "Completed";
                      }
                    });
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor(t.status),
                    disabledBackgroundColor:
                    const Color(0xFFA6A6A6),
                  ),
                  child: Text(
                    t.status == "Available"
                        ? "Claim Task"
                        : t.status,
                    style: const TextStyle(
                      color: Color(0xFFFBFBFB),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}