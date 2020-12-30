import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/services/auth.dart';

class LoginController extends GetxController {
  final Auth _auth = Auth();
  String email = '';
  String password = '';
  RxString emailErr = RxString(null);
  RxString passwordErr = RxString(null);
  Rx<Function> button = Rx<Function>(null);
  bool emailOk = false;
  bool passwordOk = false;
  var loading = false.obs;
  var loginError = RxString(null);

  void getEmailErr(String em) {
    email = em;
    if (EmailValidator.validate(em)) {
      emailErr.value = null;
      emailOk = true;
    } else {
      emailOk = false;
      emailErr.value = 'Email is Wrong';
    }

    enableButtton();
  }

  void getPasswordErr(String pass) {
    password = pass;
    if (pass.length < 6) {
      passwordOk = false;

      passwordErr.value = 'Password must be 6 characters long!';
    } else {
      passwordErr.value = null;
      passwordOk = true;
    }

    enableButtton();
  }

  void enableButtton() {
    if (emailOk && passwordOk) {
      button.value = () async {
        print(password);
        print(email);
        loading.value = true;
        loginError.value = null;

        var user = await _auth.signInUsingEmailAndPass(email, password);
        if (user.runtimeType == FirebaseAuthException) {
          loginError.value = user.message;
        }

        loading.value = false;
      };
    } else {
      button.value = null;
    }
  }

  Widget showLoading() {
    showLoginErr();

    if (loading.value) {
      return LinearProgressIndicator();
    } else {
      return SizedBox();
    }
  }

  Widget showLoginErr() {
    if (loginError.value != null) {
      return Text(
        loginError.value,
        style: TextStyle(color: Colors.red),
      );
    } else {
      return Text('');
    }
  }
}
