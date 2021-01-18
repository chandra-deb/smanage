import 'package:flutter/material.dart';
import 'package:smanage/services/auth.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth _auth = Auth();
    print(_auth.name);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('${_auth.name.toString()}'),
          Text('Class 7 monthly bill'),
          Text('Class 8 monthly bill'),
          Text('Class 9 monthly bill'),
          Text('Class 10 monthly bill'),
          Text('Class 11 monthly bill'),
          Text('Class 12 monthly bill')
        ],
      ),
    );
  }
}
