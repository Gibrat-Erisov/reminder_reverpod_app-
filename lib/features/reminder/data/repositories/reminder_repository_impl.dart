import 'package:reminder_reverpod_app/features/reminder/data/datasources/reminder_local_datasource.dart';
import 'package:reminder_reverpod_app/features/reminder/data/models/reminder_model.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderLocalDataSource _localDataSource;

  ReminderRepositoryImpl({required ReminderLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<int> createReminders(Reminder reminder) {
    final reminderModel = ReminderModel.fromEntity(reminder);
    return _localDataSource.createReminders(reminderModel);
  }

  @override
  Future<void> deleteReminders(int index) => _localDataSource.deleteReminders(index);

  @override
  Future<List<Reminder>> getReminders() async {
    final reminders = await _localDataSource.getReminders();

    return reminders.map((model) => model.toEntity()).toList();
  }
}
