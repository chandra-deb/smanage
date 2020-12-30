import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:smanage/controllers/student_details_controller.dart';

class StudentDetails extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const StudentDetails({this.doc});

  @override
  Widget build(BuildContext context) {
    final data = doc.data();
    final detailController = StudentDetailsController(doc: doc);
    detailController.test();

    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Expanded(
          child: Column(
            children: [
              Text(data['name']),
              Text(data['roll'].toString()),
              Text(data['schoolName']),
              Container(
                width: 300,
                child: ListTile(
                  leading: Text(data['phone']),
                  trailing: RaisedButton(
                      child: Icon(Icons.call),
                      onPressed: () {
                        _makeCall(data['phone']);
                      }),
                ),
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
                          return ListTile(
                            leading: Text(docs[index].id),
                            trailing: Text(
                                docs[index].data()['attendant'].toString()),
                          ); // It will show dates
                        },
                      );
                    }
                    return LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _makeCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}