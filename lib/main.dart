import 'package:flutter/material.dart';
import 'package:noteapp/view/splash_screen/SplashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async
{
  await Hive.initFlutter();
  var box = await Hive.openBox("noteBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      home: Splashscreen(),
    );
  }
}

