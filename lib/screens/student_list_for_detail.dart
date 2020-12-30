import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/screens/student_details.dart';
import 'package:smanage/services/database.dart';
import 'package:date_time_format/date_time_format.dart';

class StudentListForDetail extends StatelessWidget {
  final _db = DB();
  final int clsNumber;

  StudentListForDetail({this.clsNumber});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details of Class $clsNumber'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db.getStudentOfClass(clsNumber),
          // initialData: initialData,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              final docs = snapshot.data.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return FlatButton(
                    child: Text(docs[index].data()['name']),
                    onPressed: () {
                      Get.to(StudentDetails(
                        doc: docs[index],
                      ));
                    },
                  );
                },
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Text('What is happening!?');
          },
        ),
      ),
    );
  }
}
