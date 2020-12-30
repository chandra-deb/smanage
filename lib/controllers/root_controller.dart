import 'package:flutter/cupertino.dart';
import 'package:smanage/screens/home.dart';
import 'package:smanage/screens/login.dart';
import 'package:smanage/services/auth.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStatus(),
      builder: (BuildContext context, AsyncSnapshot user) {
        if (user.hasData) {
          return Home();
        }
        return Login();
      },
    );
  }
}
