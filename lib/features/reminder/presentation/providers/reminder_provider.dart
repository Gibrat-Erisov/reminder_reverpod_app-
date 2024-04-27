import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:reminder_reverpod_app/core/utils/notification_service.dart';
import 'package:reminder_reverpod_app/features/reminder/data/datasources/reminder_local_datasource.dart';
import 'package:reminder_reverpod_app/features/reminder/data/models/reminder_model.dart';
import 'package:reminder_reverpod_app/features/reminder/data/repositories/reminder_repository_impl.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/repositories/reminder_repository.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/usecases/create_reminders_usecase.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/usecases/delete_reminders_usecase.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/usecases/get_reminders_usecase.dart';

// data sources
final reminderLocalDataSourceProvider = Provider<ReminderLocalDataSource>((_) {
  final reminderBox = Hive.box<ReminderModel>('reminders');
  return ReminderLocalDataSourceImpl(reminderBox: reminderBox);
});

// repositories
final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  final dataSource = ref.read(reminderLocalDataSourceProvider);
  return ReminderRepositoryImpl(localDataSource: dataSource);
});

// UseCases
final createRemindersUseCaseProvider = Provider<CreateRemindersUseCase>((ref) {
  final repository = ref.read(reminderRepositoryProvider);
  return CreateRemindersUseCase(repository);
});
final deleteRemindersUseCaseProvider = Provider<DeleteRemindersUseCase>((ref) {
  final repository = ref.read(reminderRepositoryProvider);
  return DeleteRemindersUseCase(repository);
});
final getRemindersUseCaseProvider = Provider<GetRemindersUseCase>((ref) {
  final repository = ref.read(reminderRepositoryProvider);
  return GetRemindersUseCase(repository);
});

// state management
final reminderListNotifierProvider =
    StateNotifierProvider<ReminderListNotifier, List<Reminder>>((ref) {
  final createReminder = ref.read(createRemindersUseCaseProvider);
  final deleteReminder = ref.read(deleteRemindersUseCaseProvider);
  final getReminders = ref.read(getRemindersUseCaseProvider);

  return ReminderListNotifier(
    createReminder: createReminder,
    deleteReminder: deleteReminder,
    getReminders: getReminders,
  );
});

class ReminderListNotifier extends StateNotifier<List<Reminder>> {
  final CreateRemindersUseCase _createReminder;
  final DeleteRemindersUseCase _deleteReminder;
  final GetRemindersUseCase _getReminders;
  ReminderListNotifier({
    required CreateRemindersUseCase createReminder,
    required DeleteRemindersUseCase deleteReminder,
    required GetRemindersUseCase getReminders,
  })  : _getReminders = getReminders,
        _deleteReminder = deleteReminder,
        _createReminder = createReminder,
        super([]);

  Future<void> addReminder(Reminder reminder) async {
    final id = await _createReminder(reminder);

    NotificationApi.showScheduledNotification(
      id: id,
      title: reminder.title,
      body: reminder.description,
      scheduledDate: reminder.dateTime,
    );
  }

  Future<void> deleteReminder(int reminderId) async {
    await _deleteReminder(reminderId);
  }

  Future<void> getReminders() async {
    state = await _getReminders();
  }
}
