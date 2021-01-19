import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';
import 'package:smanage/utils/constants.dart';
import 'package:toast/toast.dart';

class StudentBills extends StatelessWidget {
  final Query billRef;
  final DateTime joinDate;
  final clsNumber;

  final DocumentReference teacherData =
      DB().store.collection('teachers').doc(Auth().teacherUID);

  StudentBills(
      {@required this.billRef,
      @required this.joinDate,
      @required this.clsNumber});

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
          if (docs.length == 0) {
            return Text(
              'Something Went Wrong...Connect to the Internet to get bill details',
              style: kTextStyle.copyWith(color: kUndoneColor),
            );
          }
          // int dues = duesCounter(docs);

          return StreamBuilder<DocumentSnapshot>(
              stream: teacherData.snapshots(),
              // ignore: missing_return
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  int amount = snapshot.data[clsNumber.toString()];
                  int dues = duesCounter(
                    docs,
                    amount,
                  );

                  return Column(
                    children: [
                      Text('Dues: $dues Taka',
                          style: kTextStyle.copyWith(color: Colors.black54)),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 300,
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
                                            (DateTime.now().year ==
                                                    joinDate.year
                                                ? DateTime.now().month
                                                : DateTime.now().year <
                                                        joinDate.year
                                                    ? 0
                                                    : 12) &&
                                        docs[index].data()['index'] >=
                                            joinDate.month
                                    ? () {
                                        payBill(docs, index, context);
                                      }
                                    : null,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(),
                  );
                }
              });
        }
      },
    );
  }

  Future payBill(
      List<QueryDocumentSnapshot> docs, int index, BuildContext context) async {
    {
      if (docs[index].data()['paid'] == false) {
        var value = await alertWithInput(context);
        if (value == docs[index].id) {
          await docs[index].reference.update({'paid': true});
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
  }

  int duesCounter(List<QueryDocumentSnapshot> docs, int monthlyAmount) {
    int dues = 0;
    for (var doc in docs) {
      int month = DateTime.now().year == joinDate.year
          ? DateTime.now().month
          : DateTime.now().year < joinDate.year
              ? 0
              : 12;
      if (doc.data()['index'] //* represents month index
              <=
              month &&
          doc.data()['index'] >= joinDate.month &&
          doc.data()['paid'] == false) {
        dues += monthlyAmount;
        print(doc.data());
      }
    }
    return dues;
  }
}
