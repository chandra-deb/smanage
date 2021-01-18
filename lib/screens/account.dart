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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${_auth.name.toString()}'),
          StreamBuilder(
            stream: teacherData.snapshots(),
            // ignore: missing_return
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.green.shade100,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Classes you have : ',
                            style: kTextStyle.copyWith(color: Colors.black54),
                          ),
                          ...snapshot.data['classes'].map((t) => Container(
                              padding: EdgeInsets.all(5),
                              child: Text(t.toString() + ',')))
                        ],
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
                                  List data = snapshot.data['classes'] as List;
                                  data.add(i);
                                  data.sort();

                                  await teacherData.update({'classes': data});
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
                                  List data = snapshot.data['classes'] as List;
                                  int index = data.indexOf(i);
                                  data.removeAt(index);

                                  await teacherData.update({'classes': data});
                                }
                              }
                            },
                          ),
                        ],
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
