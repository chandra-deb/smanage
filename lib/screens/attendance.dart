import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smanage/controllers/attendance_details_controller.dart';

class Attendance extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  Attendance({@required this.doc});
  @override
  Widget build(BuildContext context) {
    final attendanceDetails = AttendantDetailsController(doc: doc);
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance of ${attendanceDetails.studentName}'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              child: FutureBuilder<QuerySnapshot>(
                future: attendanceDetails.getAttendance(),
                builder:
                    // ignore: missing_return
                    (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var docs = snapshot.data.docs;

                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: docs[index].data()['attendant'] == true
                              ? Colors.green
                              : Colors.red,
                          child: ListTile(
                            leading: Text(docs[index].id),
                            trailing: Text(
                                docs[index].data()['attendant'].toString()),
                          ),
                        ); //),
                        // It will show dates
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    );
                  } else {
                    Center(
                      child: Text(
                          'Something Went. Connect to the Internet and try again!'),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
