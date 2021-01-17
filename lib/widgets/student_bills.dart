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
          int dues = duesCounter(docs);

          return Column(
            children: [
              Text('Dues: $dues Taka',
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
                                    (DateTime.now().year == joinDate.year
                                        ? DateTime.now().month
                                        : DateTime.now().year < joinDate.year
                                            ? 0
                                            : 12) &&
                                docs[index].data()['index'] >= joinDate.month
                            ? () {
                                payBill(docs, index, context);
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

  int duesCounter(List<QueryDocumentSnapshot> docs) {
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
        dues += doc.data()['amount'];
      }
    }
    return dues;
  }
}
