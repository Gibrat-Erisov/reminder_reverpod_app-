import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:reminder_reverpod_app/core/utils/date_time_picker.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_reverpod_app/features/reminder/presentation/providers/reminder_provider.dart';

class AddRemindersScreen extends ConsumerStatefulWidget {
  const AddRemindersScreen({super.key});

  @override
  ConsumerState<AddRemindersScreen> createState() => _AddRemindersScreenState();
}

class _AddRemindersScreenState extends ConsumerState<AddRemindersScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add reminder'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the title';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16),
            DateTimeButton(
              text: dateTime == null ? 'Add Date & Time' : getFormattedDate(dateTime),
              onPressed: () async {
                DateTime? pickedDateTime = await pickDateTime(context);

                setState(() {
                  dateTime = pickedDateTime;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && dateTime != null) {
                    final reminder = ref.read(reminderListNotifierProvider.notifier);
                    reminder.addReminder(Reminder(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      dateTime: dateTime!,
                      isDone: false,
                    ));

                    snackBar(context, 'Reminder set');
                  }
                },
                child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}

String getFormattedDate(DateTime? date) {
  if (date != null) {
    return DateFormat('d MMM, hh:mm aa').format(date);
  } else {
    return '';
  }
}

class DateTimeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DateTimeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.watch_later_outlined),
          const SizedBox(width: 8.0),
          Flexible(child: Text(text))
        ],
      ),
    );
  }
}
