import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/root_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xfff6f6f6),
        accentColor: Colors.green.shade500,
        appBarTheme: AppBarTheme(
          color: Colors.green.shade600,
        ),
      ),
      title: 'Student Manager',
      home: Root(),
    );
  }
}
