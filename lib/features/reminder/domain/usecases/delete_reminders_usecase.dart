import 'package:reminder_reverpod_app/features/reminder/domain/repositories/reminder_repository.dart';

class DeleteRemindersUseCase {
  final ReminderRepository _repository;

  DeleteRemindersUseCase(this._repository);

  Future<void> call(int index) async {
    return await _repository.deleteReminders(index);
  }
}
