import 'package:flutter/material.dart';

Future<DateTime?> pickDateTime(BuildContext context) async {
  DateTime? pickedDate = await pickDate(context);
  if (!context.mounted) return null;
  TimeOfDay? pickedTime = await pickTime(context);

  if (pickedTime == null || pickedDate == null) {
    if (!context.mounted) return null;
    snackBar(context, 'Please enter both date and time');
    return null;
  } else {
    DateTime date = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (date.isAfter(DateTime.now())) {
      return date;
    } else {
      if (!context.mounted) return null;
      snackBar(context, 'Time cannot be in the past!');
      return null;
    }
  }
}

Future<DateTime?> pickDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
  );

  return pickedDate;
}

Future<TimeOfDay?> pickTime(BuildContext context) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return pickedTime;
}

void snackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
