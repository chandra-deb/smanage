import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/attendance_details_controller.dart';
import 'package:smanage/utils/constants.dart';

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
      body: Obx(
        () {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: FutureBuilder(
                  future: _.attendantDaysNumber,
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                            child: Text(
                          'Counting Attendance',
                          style: kTextStyle.copyWith(color: Colors.black54),
                        ));

                      case ConnectionState.done:
                        return Center(
                          child: Text(
                            'Attended ${snapshot.data} days',
                            style: kTextStyle.copyWith(color: Colors.black54),
                          ),
                        );
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
                      // DateTime t =
                      //     (docs[index].data()['time'] as Timestamp).toDate();
                      List<QueryDocumentSnapshot> filteredDocs = [];
                      for (QueryDocumentSnapshot doc in docs) {
                        DateTime date = doc.data()['time'].toDate();
                        // !* "DateTime.friday + 3" it means Friday!
                        if (date.format('D') != 'Fri') {
                          filteredDocs.add(doc);
                        }
                      }

                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: filteredDocs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            color:
                                filteredDocs[index].data()['attendant'] == true
                                    ? kDoneColor
                                    : kUndoneColor,
                            child: ListTile(
                              leading: Text(
                                filteredDocs[index].id,
                                style: kTextStyle,
                              ),
                              // trailing: Text(
                              //   docs[index].data()['attendant'].toString(),
                              //   style: kTextStyle,
                              // ),
                              trailing: Icon(
                                filteredDocs[index].data()['attendant'] == true
                                    ? Icons.check
                                    : Icons.close_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
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
                color: Colors.blueGrey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      color: kFlatButtonColor,
                      onPressed: _.sevenDaysButton,
                      child: Text(
                        'Last 7 days',
                        style: kTextStyle.copyWith(fontSize: 20),
                      ),
                    ),
                    FlatButton(
                      color: kFlatButtonColor,
                      onPressed: _.thirtyDaysButton,
                      child: Text(
                        'Last 30 days',
                        style: kTextStyle.copyWith(fontSize: 20),
                      ),
                    ),
                    FlatButton(
                      color: kFlatButtonColor,
                      onPressed: _.unlimitedDaysButton,
                      child: Text(
                        'All',
                        style: kTextStyle.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
