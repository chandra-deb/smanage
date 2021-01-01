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

                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future:
                          RollCallController(doc: docs[index]).attendenceFuture,
                      // ignore: missing_return
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Something Went Wrong!'),
                          );
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return LinearProgressIndicator();

                          case ConnectionState.done:
                            return StreamBuilder<DocumentSnapshot>(
                                stream: RollCallController(doc: docs[index])
                                    .attendenceStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return FlatButton(
                                      onPressed: () {
                                        RollCallController(doc: docs[index])
                                            .changeAttendantToTrue();
                                      },
                                      onLongPress: () {
                                        RollCallController(doc: docs[index])
                                            .changeAttendantToFalse();
                                      },
                                      child: Text(
                                        docs[index].data()['name'] +
                                            docs[index]
                                                .data()['roll']
                                                .toString(),
                                      ),
                                      color:
                                          snapshot.data.get('attendant') == true
                                              ? Colors.green
                                              : Colors.red,
                                    );
                                  } else {
                                    return Text('Something is wrong!');
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
                return CircularProgressIndicator();
              }
              return Text('What is happening!?');
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              onLongPress: () {},
              onPressed: () {
                RollCallController.daysTimeTravel.value--;
                print('I am called On the action Bar!');
              },
              child: Text('Go back 1 day'),
            ),
            FlatButton(
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
            FlatButton(
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
