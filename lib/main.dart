import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/root_controller.dart';
import 'package:smanage/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xfff6f6f6),
        accentColor: kDoneColor,
        appBarTheme: AppBarTheme(
          color: Colors.green.shade600,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData()
            .copyWith(selectedItemColor: Colors.green.shade600),
        primaryColor: Colors.green.shade600,
        errorColor: kUndoneColor,
        indicatorColor: kDoneColor,
        cursorColor: kDoneColor,
        textSelectionColor: Colors.green.shade100,
        textSelectionHandleColor: kDoneColor,
      ),
      title: 'Student Manager',
      home: Root(),
    );
  }
}
