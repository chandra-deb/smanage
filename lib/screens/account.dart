import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:smanage/models/teacher.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';
import 'package:smanage/utils/constants.dart';
import 'package:toast/toast.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth _auth = Auth();
    final DocumentReference teacherData =
        DB().store.collection('teachers').doc(_auth.teacherUID);
    print(_auth.name);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_auth.name.toString()}'),
            StreamBuilder(
              stream: teacherData.snapshots(),
              // ignore: missing_return
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  // Map monthlyBill = snapshot.data['monthlyBillOfClass'];

                  return Container(
                    color: Colors.green.shade100,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                'Classes you have : ',
                                style:
                                    kTextStyle.copyWith(color: Colors.black54),
                              ),
                              ...snapshot.data['classes'].map(
                                (t) => Container(
                                  color: Colors.green,
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
                        Row(
                          children: [
                            FlatButton(
                              child: Text('Add Class'),
                              onPressed: () async {
                                String result = await alertWithInput(context);
                                if (int.tryParse(result) != null) {
                                  int i = int.parse(result);
                                  if (!snapshot.data['classes'].contains(i)) {
                                    List data =
                                        snapshot.data['classes'] as List;
                                    data.add(i);
                                    data.sort();
                                    final batch =
                                        FirebaseFirestore.instance.batch();
                                    batch
                                        .update(teacherData, {'classes': data});
                                    batch.update(teacherData, {'$i': 0});
                                    await batch.commit();
                                  }
                                }
                              },
                            ),
                            FlatButton(
                              child: Text('Delete Class'),
                              onPressed: () async {
                                String result = await alertWithInput(context);
                                if (int.tryParse(result) != null) {
                                  int i = int.parse(result);
                                  if (snapshot.data['classes'].contains(i) ==
                                      true) {
                                    List data =
                                        snapshot.data['classes'] as List;
                                    int index = data.indexOf(i);
                                    data.removeAt(index);

                                    await teacherData.update({'classes': data});
                                    await teacherData
                                        .update({'$i': FieldValue.delete()});
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...snapshot.data['classes'].map(
                                (t) => Container(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Text(
                                          t.toString(),
                                          style: kTextStyle.copyWith(
                                              color: Colors.black54),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'Amount is ${snapshot.data[t.toString()]}',
                                          ),
                                          onPressed: () async {
                                            String result =
                                                await alertWithInput(context);
                                            if (result != null) {
                                              if (int.tryParse(result) !=
                                                  null) {
                                                teacherData.update({
                                                  t.toString():
                                                      int.parse(result)
                                                });
                                              }
                                            }
                                          },
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ),
                        )
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
            )
          ],
        ),
      ),
    );
  }

  Future<String> alertWithInput(BuildContext context) async {
    return await prompt(
      context,
      title: Text('Do you confirm?'),
      hintText: 'Class',
      textOK: Text(
        'Confirm',
      ),
    );
  }
}
