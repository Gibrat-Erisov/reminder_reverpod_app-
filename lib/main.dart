import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder_reverpod_app/core/utils/notification_service.dart';
import 'package:reminder_reverpod_app/features/reminder/data/models/reminder_model.dart';
import 'package:reminder_reverpod_app/features/reminder/presentation/screens/add_reminders/add_reminders_screen.dart';
import 'package:reminder_reverpod_app/features/reminder/presentation/screens/reminders/reminders_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await Hive.initFlutter();
  Hive.registerAdapter(ReminderModelAdapter());
  await Hive.openBox<ReminderModel>('reminders');
  await NotificationApi.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          RemindersScreen(),
          AddRemindersScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Reminders'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Reminders'),
        ],
      ),
    );
  }
}
