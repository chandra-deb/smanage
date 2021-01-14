import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/login_controller.dart';
import 'package:smanage/screens/register.dart';

class Login extends StatelessWidget {
  final LoginController _ = LoginController();
  @override
  Widget build(BuildContext context) {
    // print(_.enableButton.value);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          FlatButton(
            onPressed: () {
              Get.off(Register());
            },
            child: Icon(Icons.app_registration),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Obx(
            () => Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: _.emailErr.value,
                  ),
                  onChanged: (value) {
                    _.getEmailErr(value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: _.passwordErr.value,
                  ),
                  onChanged: (value) {
                    _.getPasswordErr(value);
                  },
                ),
                ElevatedButton(
                  onPressed: _.button.value,
                  child: Text('login'),
                ),
                _.showLoading(),
                _.showLoginErr(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
