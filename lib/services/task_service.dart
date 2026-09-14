import '../models/task_model.dart';

class TaskService {
  List<Task> getTasks() {
    return [
      Task(
        title: "Cleaning",
        location: "C2",
        assignedTo: "Anyone",
        status: "Available",
        time: "15:00 Fri 27/3/2026",
        description: "Clean the area and maintain hygiene.",
      ),
      Task(
        title: "Shelf restocking",
        location: "A6",
        assignedTo: "Anyone",
        status: "In Progress",
        time: "14:45 Fri 27/3/2026",
        description: "Refill shelf items.",
      ),
      Task(
        title: "Crowd control",
        location: "A5",
        assignedTo: "Poezzhaeva",
        status: "Completed",
        time: "14:30 Fri 27/3/2026",
        description: "Monitor crowd movement.",
        assignedUserId: "6603523",
      ),
      Task(
        title: "Sales assistance",
        location: "B1",
        assignedTo: "Romanov",
        status: "Available",
        time: "14:23 Fri 27/3/2026",
        description: "Help customers.",
      ),
    ];
  }
}