import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'homepage.dart';
import 'time_of_day_adapter.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TimeOfDayAdapter());

  // Open the Hive box
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a MaterialColor based on white color
    MaterialColor whiteSwatch = const MaterialColor(0xFFFFFFFF, {
      50: Colors.white,
      100: Colors.white,
      200: Colors.white,
      300: Colors.white,
      400: Colors.white,
      500: Colors.white,
      600: Colors.white,
      700: Colors.white,
      800: Colors.white,
      900: Colors.white,
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(primarySwatch: whiteSwatch),
    );
  }
}
