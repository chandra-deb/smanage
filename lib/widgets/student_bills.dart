import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:smanage/utils/constants.dart';
import 'package:toast/toast.dart';

class StudentBills extends StatelessWidget {
  final Query billRef;
  final DateTime joinDate;

  StudentBills({this.billRef, this.joinDate});

  Future<String> alertWithInput(BuildContext context) async {
    print(joinDate.month);
    return await prompt(
      context,
      title: Text('Do you confirm? It can not be undone!'),
      hintText: 'Month Name',
      textOK: Text(
        'Confirm',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: billRef.snapshots(),
      builder:
          // ignore: missing_return
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Something Went Wrong...Connect to the Internet!');
        }
        if (snapshot.hasData) {
          final docs = snapshot.data.docs;
          int due = 0;
          for (var doc in docs) {
            if (doc.data()['index'] <= DateTime.now().month &&
                doc.data()['index'] >= joinDate.month &&
                doc.data()['paid'] == false) {
              due += doc.data()['amount'];
            }
          }

          return Column(
            children: [
              Text('Due: $due Taka',
                  style: kTextStyle.copyWith(color: Colors.black54)),
              Container(
                height: 600,
                child: ListView.builder(
                  itemCount: docs.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: FlatButton(
                        height: kFlatButtonHeight,
                        color: docs[index].data()['paid'] == true
                            ? kDoneColor
                            : kUndoneColor,
                        disabledColor: Colors.red.shade100,
                        onPressed: docs[index].data()['index'] <=
                                    DateTime.now().month &&
                                docs[index].data()['index'] >= joinDate.month
                            ? () async {
                                if (docs[index].data()['paid'] == false) {
                                  var value = await alertWithInput(context);
                                  if (value == docs[index].id) {
                                    await docs[index]
                                        .reference
                                        .update({'paid': true});
                                    Toast.show(
                                      'Done!',
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                    );
                                  } else {
                                    print('You are Wrong');
                                    Toast.show(
                                      'You are Wrong! Try Again!',
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                    );
                                  }
                                }
                              }
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              docs[index].id,
                              style: kTextStyle,
                            ),
                            Text(
                              docs[index].data()['paid'] == true
                                  ? 'Paid'
                                  : 'Unpaid',
                              style: kTextStyle,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

//  return Container(
//                                             margin: EdgeInsets.symmetric(
//                                                 vertical: 5),
//                                             child: FlatButton(
//                                               height: 50,
//                                               onPressed: () {
//                                                 RollCallController(doc: doc)
//                                                     .changeAttendantToTrue();
//                                               },
//                                               onLongPress: () {
//                                                 RollCallController(doc: doc)
//                                                     .changeAttendantToFalse();
//                                               },
//                                               child: Row(children: [
//                                                 Expanded(
//                                                   flex: 1,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                       left: 15,
//                                                       // right: 21,
//                                                     ),
//                                                     child: Text(
//                                                       doc
//                                                           .data()['roll']
//                                                           .toString(),
//                                                       style: kTextStyle,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 5,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                       left: 15,
//                                                     ),
//                                                     child: Text(
//                                                       doc.data()['name'],
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: kTextStyle,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 1,
//                                                   child: Icon(
//                                                     snapshot.data.get(
//                                                                 'attendant') ==
//                                                             true
//                                                         ? Icons.check
//                                                         : Icons.close_rounded,
//                                                     color: Colors.white,
//                                                     size: 40,
//                                                   ),
//                                                 ),
//                                               ]),
//                                               color: snapshot.data
//                                                           .get('attendant') ==
//                                                       true
//                                                   ? kDoneColor
//                                                   : kUndoneColor,
//                                             ),
//                                           );
