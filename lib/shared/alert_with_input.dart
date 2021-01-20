import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

Future<String> alertWithInput(
  BuildContext context, {
  @required String title,
  @required String hintText,
  @required String textOk,
  @required String textCancel,
  @required Color okButtonColor,
  @required Color cancelButtonColor,
}) async {
  return await prompt(context,
      title: Text(
        title,
        style: TextStyle(color: Colors.black54),
      ),
      hintText: hintText,
      okButtonColor: okButtonColor,
      cancelButtonColor: cancelButtonColor,
      textOkColor: Colors.white,
      textCancelColor: Colors.white,
      textOK: Text(
        textOk,
        style: TextStyle(color: Colors.white),
      ),
      textCancel: Text(
        textCancel,
        style: TextStyle(color: Colors.white),
      ));
}
