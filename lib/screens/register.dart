import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: [
          FlatButton(
            onPressed: () {
              Get.off(Login());
            },
            child: Icon(Icons.login),
          )
        ],
      ),
    );
  }
}
