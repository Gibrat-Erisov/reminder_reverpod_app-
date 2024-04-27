import 'package:reminder_reverpod_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/repositories/reminder_repository.dart';

class GetRemindersUseCase {
  final ReminderRepository _repository;

  GetRemindersUseCase(this._repository);

  Future<List<Reminder>> call() async {
    return await _repository.getReminders();
  }
}
