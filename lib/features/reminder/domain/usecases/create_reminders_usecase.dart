import 'package:reminder_reverpod_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/repositories/reminder_repository.dart';

class CreateRemindersUseCase {
  final ReminderRepository _repository;

  CreateRemindersUseCase(this._repository);

  Future<int> call(Reminder reminder) async {
    return await _repository.createReminders(reminder);
  }
}
