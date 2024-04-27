import 'package:hive/hive.dart';
import 'package:reminder_reverpod_app/features/reminder/data/models/reminder_model.dart';

abstract interface class ReminderLocalDataSource {
  Future<List<ReminderModel>> getReminders();
  Future<int> createReminders(ReminderModel reminder);
  Future<void> deleteReminders(int index);
}

class ReminderLocalDataSourceImpl implements ReminderLocalDataSource {
  final Box<ReminderModel> _reminderBox;

  ReminderLocalDataSourceImpl({required Box<ReminderModel> reminderBox})
      : _reminderBox = reminderBox;

  @override
  Future<int> createReminders(ReminderModel reminder) => _reminderBox.add(reminder);

  @override
  Future<void> deleteReminders(int index) => _reminderBox.deleteAt(index);

  @override
  Future<List<ReminderModel>> getReminders() async =>
      _reminderBox.values.toList().reversed.toList();
}
