class Task {
  final String title;
  final String location;
  String assignedTo;
  String status;
  final String time;
  final String description;

  String? assignedUserId;

  Task({
    required this.title,
    required this.location,
    required this.assignedTo,
    required this.status,
    required this.time,
    required this.description,
    this.assignedUserId,
  });
}