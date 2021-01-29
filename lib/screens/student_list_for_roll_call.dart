import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/roll_call_controller.dart';
import 'package:smanage/services/database.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:smanage/utils/constants.dart';

class StudentListForRC extends StatelessWidget {
  final _db = DB();
  final String clsNumber;

  StudentListForRC({this.clsNumber});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text('Class $clsNumber (${DateTime.now().add(
                Duration(days: RollCallController.getDay),
              ).format('D, M j')})'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DateTime.now()
                        .add(Duration(days: RollCallController.getDay))
                        .format('D') ==
                    'Fri'
                ? Container(
                    margin: EdgeInsets.only(
                      top: 250,
                      left: 50,
                      right: 50,
                    ),
                    child: Center(
                      child: Center(
                          child: Text(
                        'Today is Holiday! You can see previous days attendances',
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(color: Colors.black54),
                      )),
                    ),
                  )
                : Expanded(
                    child: Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _db.getStudentOfClass(clsNumber),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final docs = snapshot.data.docs;
                            if (docs.length == 0) {
                              return Center(
                                child: Text(
                                  'No Student added in this Class',
                                  style: kTextStyle.copyWith(
                                      color: Colors.black38),
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                  future: RollCallController(doc: docs[index])
                                      .attendenceFuture,
                                  // ignore: missing_return
                                  builder:
                                      // ignore: missing_return
                                      (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                    if (snapshot.hasError) {
                                      return Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: FlatButton(
                                          // !It Shows....Other 'Something went wrong not work
                                          height: kFlatButtonHeight,
                                          child: Text(
                                            'Something Went Wrong',
                                            style: kTextStyle.copyWith(
                                                color: Colors.black26),
                                          ),
                                          onPressed: null,
                                        ),
                                      );
                                    }
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: FlatButton(
                                            onPressed: null,
                                            height: kFlatButtonHeight,
                                            child: Text(
                                              'Loading',
                                              // textAlign: TextAlign.center,
                                              style: kTextStyle.copyWith(
                                                  color: Colors.black26),
                                            ),
                                          ),
                                        );

                                      case ConnectionState.done:
                                        return StreamBuilder<DocumentSnapshot>(
                                            stream: RollCallController(
                                                    doc: docs[index])
                                                .attendenceStream,
                                            builder: (context, snapshot) {
                                              var doc = docs[index];
                                              if (snapshot.hasData) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: FlatButton(
                                                    height: kFlatButtonHeight,
                                                    onPressed: () {
                                                      RollCallController(
                                                              doc: doc)
                                                          .changeAttendantToTrue();
                                                    },
                                                    onLongPress: () {
                                                      RollCallController(
                                                              doc: doc)
                                                          .changeAttendantToFalse();
                                                    },
                                                    child: Row(children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15,
                                                            // right: 21,
                                                          ),
                                                          child: Text(
                                                            doc
                                                                .data()['roll']
                                                                .toString(),
                                                            style: kTextStyle,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15,
                                                          ),
                                                          child: Text(
                                                            doc.data()['name'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: kTextStyle,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Icon(
                                                          snapshot.data.get(
                                                                      'attendant') ==
                                                                  true
                                                              ? Icons.check
                                                              : Icons
                                                                  .close_rounded,
                                                          color: Colors.white,
                                                          size: 40,
                                                        ),
                                                      ),
                                                    ]),
                                                    color: snapshot.data.get(
                                                                'attendant') ==
                                                            true
                                                        ? kDoneColor
                                                        : kUndoneColor,
                                                  ),
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

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                  ),
            Container(
              color: Colors.blueGrey.shade200,
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    // height: kFlatButtonHeight,
                    color: kFlatButtonColor,
                    colorBrightness: Brightness.dark,
                    onLongPress: () {
                      // RollCallController.daysTimeTravel.value -= 5;
                    },
                    onPressed: () {
                      if (DateTime.now()
                              .add(Duration(
                                  days:
                                      RollCallController.daysTimeTravel.value -
                                          1))
                              .year ==
                          DateTime.now().year) {
                        RollCallController.daysTimeTravel.value--;
                      }
                    },
                    child: Text(
                      RollCallController.getBackwardMessage(),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  FlatButton(
                    // height: kFlatButtonHeight,
                    color: kFlatButtonColor,
                    colorBrightness: Brightness.dark,
                    onPressed: () {
                      if (RollCallController.daysTimeTravel.value < 0) {
                        RollCallController.daysTimeTravel.value++;
                        print('I am called On the action Bar!');
                      } else {
                        print('I can\'t go forward anymore');
                      }
                    },
                    child: Text(
                      RollCallController.getForwardMessage(),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  FlatButton(
                    // height: kFlatButtonHeight,
                    color: kFlatButtonColor,
                    colorBrightness: Brightness.dark,
                    onPressed: () {
                      RollCallController.daysTimeTravel.value = 0;
                    },
                    // child: Text(
                    //   'Today',
                    //   style: kFlatButtonTextStyle,
                    // ),
                    child: Icon(
                      Icons.today_sharp,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
