import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

void showToast({String msg, BuildContext context}) {
  Toast.show(
    msg,
    context,
    duration: Toast.LENGTH_LONG,
    gravity: Toast.BOTTOM,
  );
}
