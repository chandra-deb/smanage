import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class StudentDetails extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const StudentDetails({this.doc});

  @override
  Widget build(BuildContext context) {
    final data = doc.data();
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(data['name']),
            Text(data['roll'].toString()),
            Text(data['schoolName']),
            Container(
              width: 300,
              child: ListTile(
                leading: Text(data['phone']),
                trailing: RaisedButton(
                    child: Icon(Icons.call),
                    onPressed: () {
                      _makeCall(data['phone']);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _makeCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
