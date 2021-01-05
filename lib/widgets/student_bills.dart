import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
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
    return Flexible(
      child: Container(
        child: StreamBuilder(
          stream: billRef.snapshots(),
          builder:
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
                  Text('Due: $due Taka', style: TextStyle(fontSize: 25)),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: docs.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FlatButton(
                          color: docs[index].data()['paid'] == true
                              ? Colors.greenAccent
                              : Colors.redAccent,
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
                                Text(docs[index].id),
                                Text(
                                  docs[index].data()['paid'] == true
                                      ? 'Paid'
                                      : 'Unpaid',
                                ),
                              ]),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
