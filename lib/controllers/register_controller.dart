import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/services/auth.dart';

class RegisterController extends GetxController {
  final Auth _auth = Auth();
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword;
  RxString confirmPasswordErr = RxString(null);
  RxString nameErr = RxString(null);

  RxString emailErr = RxString(null);
  RxString passwordErr = RxString(null);
  Rx<Function> button = Rx<Function>(null);
  bool nameOk = false;
  bool emailOk = false;
  bool passwordOk = false;
  bool confirmPasswordOk = false;
  var loading = false.obs;
  var registrationErr = RxString(null);

  void getNameErr(String nm) {
    name = nm;
    if (nm.length >= 4) {
      nameErr.value = null;
      nameOk = true;
    } else {
      nameOk = false;
      nameErr.value = 'Name must be atleast 4 characters!';
    }

    enableButtton();
  }

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

    if ((password != confirmPassword) && confirmPassword.length != 0) {
      confirmPasswordOk = false;
      confirmPasswordErr.value = 'It is not equal as password!';
    } else {
      confirmPasswordOk = true;
      confirmPasswordErr.value = null;
    }
    enableButtton();
  }

  void getConfirmPasswordErr(String confirmPass) {
    confirmPassword = confirmPass;

    if (password != confirmPassword) {
      confirmPasswordErr.value = 'It is not equal as password!';
      confirmPasswordOk = false;
    } else {
      confirmPasswordErr.value = null;
      confirmPasswordOk = true;
    }

    enableButtton();
  }

  void enableButtton() {
    if (nameOk && emailOk && passwordOk && confirmPasswordOk) {
      button.value = () async {
        loading.value = true;
        registrationErr.value = null;

        var user = await _auth.createUser(
            name: name, email: email, password: password);
        if (user.runtimeType != UserCredential) {
          registrationErr.value = user.message;
        }

        loading.value = false;
      };
    } else {
      button.value = null;
    }
  }

  Widget showLoading() {
    showRegistrationErr();

    if (loading.value) {
      return LinearProgressIndicator();
    } else {
      return SizedBox();
    }
  }

  Widget showRegistrationErr() {
    if (registrationErr.value != null) {
      return Text(
        registrationErr.value,
        style: TextStyle(color: Colors.red),
      );
    } else {
      return Text('');
    }
  }
}
