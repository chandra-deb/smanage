import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/student_deletion_controller.dart';
import 'package:smanage/models/student_details_model.dart';
import 'package:smanage/screens/attendance.dart';
import 'package:smanage/widgets/student_bills.dart';

class StudentDetails extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const StudentDetails({this.doc});

  @override
  Widget build(BuildContext context) {
    final _ = StudentDetailsModel(doc);
    final data = doc.data();
    return Scaffold(
      appBar: AppBar(
        title: Text(_.name),
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
            Text(_.name),
            Text(_.roll),
            Text(_.institutionName),
            Container(
              // width: 300,
              // Todo: I have to finish up this phone calling thing in 09 January! !
              child: Column(
                children: _.phoneNumbers.map((v) {
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
                }).toList(),
              ),
            ),
            StudentBills(
              joinDate: _.joinDate,
              billRef: _.bills,
            ),

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
