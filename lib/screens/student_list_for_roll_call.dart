import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/roll_call_controller.dart';
import 'package:smanage/services/database.dart';
import 'package:date_time_format/date_time_format.dart';

class StudentListForRC extends StatelessWidget {
  final _db = DB();
  final int clsNumber;

  StudentListForRC({this.clsNumber});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text('RC of $clsNumber (${DateTime.now().add(
                Duration(days: RollCallController.getDay),
              ).format('D, M j')})'),
          centerTitle: true,
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: _db.getStudentOfClass(clsNumber),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final docs = snapshot.data.docs;
                if (docs.length == 0) {
                  return Center(
                    child: Text('No Student added in this Class'),
                  );
                }
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future:
                          RollCallController(doc: docs[index]).attendenceFuture,
                      // ignore: missing_return
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return FlatButton(
                            // !It Shows....Other 'Something went wrong not work
                            height: 40,
                            child: Text('Something Went Wrong'),
                            onPressed: null,
                          );
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return FlatButton(
                              onPressed: null,
                              height: 40,
                              child: Text(
                                'Loading',
                                textAlign: TextAlign.center,
                                // strutStyle: StrutStyle(
                                //   height: 40,
                                // ),
                              ),
                            );

                          case ConnectionState.done:
                            return StreamBuilder<DocumentSnapshot>(
                                stream: RollCallController(doc: docs[index])
                                    .attendenceStream,
                                builder: (context, snapshot) {
                                  var doc = docs[index];
                                  if (snapshot.hasData) {
                                    return FlatButton(
                                      height: 40,
                                      onPressed: () {
                                        RollCallController(doc: doc)
                                            .changeAttendantToTrue();
                                      },
                                      onLongPress: () {
                                        RollCallController(doc: doc)
                                            .changeAttendantToFalse();
                                      },
                                      child: Text(
                                        doc.data()['name'] +
                                            doc.data()['roll'].toString(),
                                      ),
                                      color:
                                          snapshot.data.get('attendant') == true
                                              ? Colors.green
                                              : Colors.red,
                                    );
                                  } else {
                                    return Text('');
                                  }
                                });
                          case ConnectionState.none:
                            // TODO: Handle this case.
                            break;
                          case ConnectionState.active:
                            // TODO: Handle this case.
                            break;
                        }
                      },
                    );
                  },
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return FlatButton(
                height: 40,
                child: Text('Something Went Wrong!'),
                onPressed: null,
              );
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onLongPress: () {
                // RollCallController.daysTimeTravel.value -= 5;
              },
              onPressed: () {
                if (DateTime.now()
                        .add(Duration(
                            days: RollCallController.daysTimeTravel.value - 1))
                        .year ==
                    DateTime.now().year) {
                  RollCallController.daysTimeTravel.value--;
                }
              },
              child: Text(RollCallController.getBackwardMessage()),
            ),
            ElevatedButton(
              onPressed: () {
                if (RollCallController.daysTimeTravel.value < 0) {
                  RollCallController.daysTimeTravel.value++;
                  print('I am called On the action Bar!');
                } else {
                  print('I can\'t go forward anymore');
                }
              },
              child: Text(RollCallController.getForwardMessage()),
            ),
            ElevatedButton(
              onPressed: () {
                RollCallController.daysTimeTravel.value = 0;
                print('I am called On the action Bar!');
              },
              child: Text('Today'),
            )
          ],
        ),
      );
    });
  }
}
