class Reminder {
  final String title;
  final String? description;
  final DateTime dateTime;
  final bool isDone;

  const Reminder({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isDone,
  });
}
