import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smanage/controllers/roll_call_controller.dart';
import 'package:smanage/services/database.dart';
import 'package:date_time_format/date_time_format.dart';

class StudentList extends StatelessWidget {
  final _db = DB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roll Call ${DateTime.now().format('D, M j')}'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db.getStudentOfClass(10),
          // initialData: initialData,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              final docs = snapshot.data.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  // var docRef =
                  //     docs[index].reference.collection('attendence').doc('ll');
                  // docRef.get().then((document) {});

                  // ToDo : Here i will return getx
                  return FutureBuilder(
                    future:
                        RollCallController(doc: docs[index]).attendenceFuture,
                    // initialData: InitialData,
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
                                      print(snapshot.data.get('attendant'));
                                      RollCallController(doc: docs[index])
                                          .changeAttendantToTrue();
                                    },
                                    onLongPress: () {
                                      RollCallController(doc: docs[index])
                                          .changeAttendantToFalse();
                                    },
                                    child: Text(
                                      docs[index].data()['name'] +
                                          docs[index].data()['roll'].toString(),
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

                  // StreamBuilder<DocumentSnapshot>(
                  //     stream:
                  //         RollCallController(doc: docs[index]).attendenceStream,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         return FlatButton(
                  //           onPressed: () {
                  //             print(snapshot.data.get('attendant'));
                  //             RollCallController(doc: docs[index])
                  //                 .changeAttendantToTrue();
                  //           },
                  //           onLongPress: () {
                  //             RollCallController(doc: docs[index])
                  //                 .changeAttendantToFalse();
                  //           },
                  //           child: Text(
                  //             docs[index].data()['name'] +
                  //                 docs[index].data()['roll'].toString(),
                  //           ),
                  //           color: snapshot.data.get('attendant') == true
                  //               ? Colors.green
                  //               : Colors.red,
                  //         );
                  //       } else {
                  //         return Text('Something is wrong!');
                  //       }
                  //     });
                },
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Text('no');
          },
        ),
      ),
    );
  }
}

//!! if anything goes wrong! backed up here!
// StreamBuilder<DocumentSnapshot>(
//                       stream:
//                           RollCallController(doc: docs[index]).attendenceStream,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           return FlatButton(
//                             onPressed: () {
//                               print(snapshot.data.get('attendant'));
//                               RollCallController(doc: docs[index])
//                                   .changeAttendantToTrue();
//                             },
//                             onLongPress: () {
//                               RollCallController(doc: docs[index])
//                                   .changeAttendantToFalse();
//                             },
//                             child: Text(
//                               docs[index].data()['name'] +
//                                   docs[index].data()['roll'].toString(),
//                             ),
//                             color: snapshot.data.get('attendant') == true
//                                 ? Colors.green
//                                 : Colors.red,
//                           );
//                         } else {
//                           return Text('Something is wrong!');
//                         }
//                       });
