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
        return Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    FlatButton(
                      onPressed: _.sevenDaysButton,
                      child: Text('Last 7 days'),
                    ),
                    FlatButton(
                      onPressed: _.thirtyDaysButton,
                      child: Text('Last 30 days'),
                    ),
                    FlatButton(
                      onPressed: _.unlimitedDaysButton,
                      child: Text('All'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                color: Colors.black,
                child: FutureBuilder<QuerySnapshot>(
                  future: _.getAttendance(),
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
        );
      }),
    );
  }
}
