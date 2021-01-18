import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:smanage/models/teacher.dart';
import 'package:smanage/services/auth.dart';
import 'package:smanage/services/database.dart';
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
                          Text('Classes you have:'),
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
                                int i = int.tryParse(result);
                                if (snapshot.data['classes'].contains(i)) {
                                  return;
                                } else {
                                  List data = snapshot.data['classes'] as List;
                                  data.add(i);
                                  data.sort();

                                  await teacherData.update({'classes': data});
                                }
                              } else
                                return;
                            },
                          ),
                          FlatButton(
                            child: Text('Delete Class'),
                            onPressed: () async {
                              String result = await alertWithInput(context);
                              // print(teacherData.path);
                              print(snapshot.data['classes']
                                  .contains(int.tryParse(result)));
                              if (snapshot.data['classes']
                                      .contains(int.tryParse(result)) ==
                                  true) {
                                List data = snapshot.data['classes'] as List;
                                int index = data.indexOf(int.parse(result));
                                var updatedData = data.removeAt(index);
                                print(data);
                                print(updatedData);
                                try {
                                  await teacherData.update({'classes': data});
                                } on Exception catch (e) {
                                  Toast.show(
                                    'Something Went Wrong!',
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM,
                                  );
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
