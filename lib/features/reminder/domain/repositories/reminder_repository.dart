import 'package:reminder_reverpod_app/features/reminder/domain/entities/reminder.dart';

abstract interface class ReminderRepository {
  Future<List<Reminder>> getReminders();
  Future<int> createReminders(Reminder reminder);
  Future<void> deleteReminders(int index);
}
