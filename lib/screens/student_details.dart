import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/student_deletion_controller.dart';
import 'package:smanage/screens/attendance.dart';
import 'package:smanage/widgets/student_bills.dart';

class StudentDetails extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const StudentDetails({this.doc});

  @override
  Widget build(BuildContext context) {
    final data = doc.data();
    final billRef = doc.reference.collection('bills').orderBy('index');
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
        actions: [
          FlatButton(
            onPressed: () {
              Get.to(Attendance(
                doc: doc,
              ));
            },
            child: Text('Get Attendance'),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(data['name']),
            Text(data['roll'].toString()),
            Text(data['schoolName']),
            Container(
              // width: 300,
              // Todo: I have to finish up this phone calling thing!
              child: Column(children: [
                ...data['phoneNumbers'].map((v) {
                  // return Text(v.keys.first);

                  return ListTile(
                    title: Text(v[v.keys.first]),
                    leading: Text(v.keys.first),
                    trailing: RaisedButton(
                        child: Icon(Icons.call),
                        onPressed: () {
                          _makeCall(v[v.keys.first]);
                        }),
                  );
                })
              ]),
            ),
            StudentBills(
              joinDate: data['joinDate'].toDate(),
              billRef: billRef,
            ),
            // Text(
            //   'Attendance',
            //   style: TextStyle(fontSize: 20),
            // ),

            // Todo   App deletion function ...Need Some functionalities Here
            FlatButton(
              onPressed: () {
                StudentDeletionController(doc).delete(context);
              },
              child: Text('Delete Student'),
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
