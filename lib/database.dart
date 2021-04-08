import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference presCollection = FirebaseFirestore.instance.collection('prescription');

  Future adddata({String doctor, String description, String medicines,String url,DateTime date,String prescText}) async {
    print(doctor+"jkjj");
    return await presCollection.doc(uid).collection('pres').doc(date.toString()).set({
      'doctor': doctor,
      'description' : description,
      'medicines' : medicines,
      'url' : url,
      'submissionTime' : date,
      "prescText" : prescText
    }
    );
  }

}