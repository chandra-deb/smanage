import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/register_controller.dart';

class Register extends StatelessWidget {
  final RegisterController _ = RegisterController();
  final Function toggleView;

  Register({this.toggleView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: [
          FlatButton(
            onPressed: toggleView,
            child: Icon(Icons.login),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(30),
          child: Obx(
            () => Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    errorText: _.nameErr.value,
                  ),
                  onChanged: (value) {
                    _.getNameErr(value);
                  },
                ),
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    errorText: _.confirmPasswordErr.value,
                  ),
                  onChanged: (value) {
                    _.getConfirmPasswordErr(value);
                  },
                ),
                ElevatedButton(
                  onPressed: _.button.value,
                  child: Text('Register'),
                ),
                _.showLoading(),
                _.showRegistrationErr(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
