import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/attendance_details_controller.dart';

class Attendance extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  Attendance({@required this.doc});
  @override
  Widget build(BuildContext context) {
    final _ = AttendantDetailsController(doc: doc);
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance of ${_.studentName}'),
      ),
      body: Obx(() {
        return Column(
          children: [
            Container(
              child: FutureBuilder(
                future: _.attendantDaysNumber,
                // ignore: missing_return
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: Text('Counting Attendance'));

                    case ConnectionState.done:
                      return Center(
                          child: Text('Attended ${snapshot.data} days'));
                    case ConnectionState.none:
                      // TODO: Handle this case.
                      break;
                    case ConnectionState.active:
                      // TODO: Handle this case.
                      break;
                  }
                },
              ),
            ),
            Flexible(
              child: FutureBuilder<QuerySnapshot>(
                future: _.getAttendance,
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _.sevenDaysButton,
                    child: Text('Last 7 days'),
                  ),
                  ElevatedButton(
                    onPressed: _.thirtyDaysButton,
                    child: Text('Last 30 days'),
                  ),
                  ElevatedButton(
                    onPressed: _.unlimitedDaysButton,
                    child: Text('All'),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
