import 'package:hive/hive.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/entities/reminder.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final bool isDone;

  ReminderModel({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });

  factory ReminderModel.fromEntity(Reminder entity) => ReminderModel(
        title: entity.title,
        description: entity.description,
        dateTime: entity.dateTime,
        isDone: entity.isDone,
      );

  Reminder toEntity() => Reminder(
        title: title,
        description: description,
        dateTime: dateTime,
        isDone: isDone,
      );
}
