// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'messageAwe.dart';
import 'spinner.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';
import 'SignUp.dart';

void callbackDispatcher() async {
  Workmanager().executeTask(
    (taskName, inputData) {
      if (DateTime.now().minute + 30 >= 45) {
        NotificationServices25().scheduleNotification25();
      } else {
        NotificationServices27().scheduleNotification27();
      }
      return Future.value(true);
    },
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationServices25();
  NotificationServices27();
  tz.initializeTimeZones();
  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    "task",
    "task",
    frequency: const Duration(minutes: 15),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: './home',
        routes: {
          '/': (context) => const Spinner(),
          '/home': (context) => const SignUp(),
        },
      ),
    );
  }
}
