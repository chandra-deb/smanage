import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Class 6 monthly bill'),
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
