import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:smanage/controllers/student_details_controller.dart';
import 'package:smanage/widgets/student_bills.dart';

class StudentDetails extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const StudentDetails({this.doc});

  @override
  Widget build(BuildContext context) {
    final data = doc.data();
    final billRef = doc.reference.collection('bills').orderBy('index');
    final detailController = StudentDetailsController(doc: doc);
    detailController.test();

    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(data['name']),
            Text(data['roll'].toString()),
            Text(data['schoolName']),
            Container(
              // width: 300,
              // Todo: I have to finish up this phone calling thing!
              child: Column(children: [
                ...data['phoneNumbers'].map((v) {
                  // return Text(v.keys.first);

                  return ListTile(
                    title: Text(v[v.keys.first]),
                    leading: Text(v.keys.first),
                    trailing: RaisedButton(
                        child: Icon(Icons.call),
                        onPressed: () {
                          _makeCall(v[v.keys.first]);
                        }),
                  );
                })
              ]
                  // children: [
                  //   data['phoneNumbers'].map((Map<String, String> number) {
                  //     return Text('number.toString()');
                  //   }).toList(),
                  // ListTile(
                  //   leading: Text(data['phone']),
                  //   trailing: RaisedButton(
                  //       child: Icon(Icons.call),
                  //       onPressed: () {
                  //         _makeCall(data['phone']);
                  //       }),
                  // ),
                  // ],
                  ),
            ),
            StudentBills(
              joinDate: data['joinDate'].toDate(),
              billRef: billRef,
            ),
            Text(
              'Attendance',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 250,
              child: FutureBuilder<QuerySnapshot>(
                future: detailController.test(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var docs = snapshot.data.docs;

                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(docs[index].data());
                        return Container(
                          color: docs[index].data()['attendant'] == true
                              ? Colors.green
                              : Colors.red,
                          child: ListTile(
                            leading: Text(docs[index].id),
                            trailing: Text(
                                docs[index].data()['attendant'].toString()),
                          ),
                        ); //),
                        // It will show dates
                      },
                    );
                  }
                  return LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                  );
                },
              ),
            ),
            // Todo   App deletion function ...Need Some functionalities Here
            FlatButton(
              onPressed: () async {
                final batch = FirebaseFirestore.instance.batch();

                await doc.reference
                    .collection('attendance')
                    .get()
                    .then((value) {
                  for (var doc in value.docs) {
                    batch.delete(doc.reference);
                  }
                });

                await doc.reference.collection('bills').get().then((value) {
                  for (var doc in value.docs) {
                    batch.delete(doc.reference);
                  }
                });

                batch.delete(doc.reference);

                await batch.commit();
                Get.back();
              },
              child: Text('Delete'),
            )
          ],
        ),
      ),
    );
  }

  void _makeCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
