import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reminder_reverpod_app/features/reminder/presentation/providers/reminder_provider.dart';
import 'package:reminder_reverpod_app/features/reminder/presentation/screens/reminders/widgets/reaminder_card.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(reminderListNotifierProvider.notifier).getReminders();
    final reminders = ref.watch(reminderListNotifierProvider);
    return ListView.builder(
      itemCount: reminders.length,
      itemBuilder: (_, index) => ReminderCard(
        reminders[index],
      ),
    );
  }
}
