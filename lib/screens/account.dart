import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';
import 'package:smanage/shared/alert_with_input.dart';
import 'package:smanage/utils/constants.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth _auth = Auth();
    final DocumentReference teacherData =
        DB().store.collection('teachers').doc(_auth.teacherUID);
    print(_auth.name);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                '${_auth.name.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black54,
                ),
              ),
            ),
            StreamBuilder(
              stream: teacherData.snapshots(),
              // ignore: missing_return
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  // Map monthlyBill = snapshot.data['monthlyBillOfClass'];

                  return Container(
                    color: Colors.green.shade100,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: snapshot.data['classes'].length == 0
                              ? Text(
                                  'You have not added any class yet',
                                  style: kTextStyle.copyWith(
                                      color: Colors.black54),
                                )
                              : Row(
                                  children: [
                                    Text(
                                      'Classes you have : ',
                                      style: kTextStyle.copyWith(
                                          color: Colors.black54),
                                    ),
                                    ...snapshot.data['classes'].map(
                                      (t) => Container(
                                        color: Colors.green.shade200,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        margin: EdgeInsets.all(5),
                                        child: Text(
                                          t.toString(),
                                          style: kTextStyle.copyWith(
                                              color: Colors.black54),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2, bottom: 20),
                          child: Row(
                            children: [
                              FlatButton(
                                color: kDoneColor,
                                child: Text(
                                  'Add Class',
                                  style: kTextStyle.copyWith(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                onPressed: () async {
                                  String result = await alertWithInput(context,
                                      cancelButtonColor: kDoneColor,
                                      okButtonColor: kDoneColor,
                                      hintText: 'Enter Class number',
                                      textOk: 'Add',
                                      textCancel: 'Cancel',
                                      title: 'Do you want to add a new class?');
                                  if (result != null) {
                                    if (int.tryParse(result) != null) {
                                      int i = int.parse(result);
                                      if (!snapshot.data['classes']
                                          .contains(i)) {
                                        List data =
                                            snapshot.data['classes'] as List;
                                        data.add(i);
                                        data.sort();
                                        final batch =
                                            FirebaseFirestore.instance.batch();
                                        batch.update(
                                            teacherData, {'classes': data});
                                        batch.update(teacherData, {'$i': 0});
                                        await batch.commit();
                                      }
                                    }
                                  }
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              FlatButton(
                                color: kUndoneColor,
                                child: Text(
                                  'Delete Class',
                                  style: kTextStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () async {
                                  String result = await alertWithInput(context,
                                      textCancel: 'Cancel',
                                      cancelButtonColor: kDoneColor,
                                      okButtonColor: Colors.red,
                                      hintText: 'Enter class number',
                                      textOk: 'Delete',
                                      title:
                                          'Do you want to delete this class?');
                                  if (result != null) {
                                    if (int.tryParse(result) != null) {
                                      int i = int.parse(result);
                                      if (snapshot.data['classes']
                                              .contains(i) ==
                                          true) {
                                        List data =
                                            snapshot.data['classes'] as List;
                                        int index = data.indexOf(i);
                                        data.removeAt(index);

                                        await teacherData
                                            .update({'classes': data});
                                        await teacherData.update(
                                            {'$i': FieldValue.delete()});
                                      }
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        snapshot.data['classes'].length == 0
                            ? SizedBox()
                            : Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        'Monthly bill of class',
                                        style: kTextStyle.copyWith(
                                            color: Colors.black54),
                                      ),
                                    ),
                                    ...snapshot.data['classes'].map(
                                      (t) => Container(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              t.toString() + '  is',
                                              style: kTextStyle.copyWith(
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              height: 30,
                                              child: FlatButton(
                                                color: kDoneColor,
                                                child: Text(
                                                  '${snapshot.data[t.toString()]}',
                                                  style: kTextStyle.copyWith(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  String result =
                                                      await alertWithInput(
                                                          context,
                                                          textCancel: 'Cancel',
                                                          cancelButtonColor:
                                                              kDoneColor,
                                                          okButtonColor:
                                                              kDoneColor,
                                                          hintText:
                                                              'Enter amount',
                                                          textOk: 'Delete',
                                                          title:
                                                              'Set monthly bill of class $t');
                                                  if (result != null) {
                                                    if (int.tryParse(result) !=
                                                        null) {
                                                      teacherData.update(
                                                        {
                                                          t.toString():
                                                              int.parse(result)
                                                        },
                                                      );
                                                    }
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
