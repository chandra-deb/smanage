import 'package:flutter/cupertino.dart';
import 'package:smanage/controllers/authenticate_controller.dart';
import 'package:smanage/screens/home.dart';
import 'package:smanage/screens/login.dart';
import 'package:smanage/services/auth.dart';

class Root extends StatelessWidget {
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStatus(),
      builder: (BuildContext context, AsyncSnapshot user) {
        if (user.hasData) {
          return Home();
        }
        return Authenticate();
      },
    );
  }
}
