import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/login_controller.dart';
import 'package:smanage/utils/constants.dart';

class Login extends StatelessWidget {
  final LoginController _ = LoginController();

  final Function toggleView;
  Login({this.toggleView});

  @override
  Widget build(BuildContext context) {
    // print(_.enableButton.value);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          FlatButton(
            onPressed: toggleView,
            child: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
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
                  obscureText: true,
                  onChanged: (value) {
                    _.getPasswordErr(value);
                  },
                ),
                FlatButton(
                  color: kDoneColor,
                  disabledColor: Colors.green.shade100,
                  onPressed: _.button.value,
                  child: Text(
                    'login',
                  ),
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
