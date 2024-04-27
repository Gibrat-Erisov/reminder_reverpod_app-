import 'package:flutter/material.dart';
import 'package:reminder_reverpod_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_reverpod_app/features/reminder/presentation/screens/add_reminders/add_reminders_screen.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  const ReminderCard(this.reminder, {super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    reminder.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      height: 1.1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  //add a little space between title and desc.
                  reminder.description != null
                      ? const SizedBox(height: 6.0)
                      : const SizedBox.shrink(),

                  // description
                  reminder.description != null
                      ? Text(
                          reminder.description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 16, height: 1.2),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),

          // date of the reminder
          _dateTimeChip(context),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _dateTimeChip(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Chip(
        backgroundColor: Theme.of(context).colorScheme.primary,
        label: Text(
          getFormattedDate(reminder.dateTime),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const MyCard({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Material(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8.0),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
