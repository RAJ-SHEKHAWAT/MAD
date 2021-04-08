import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference presCollection = FirebaseFirestore.instance.collection('prescription');

  Future adddata(String doctor, String description, String medicines) async {
    return await presCollection.doc(uid).collection('pres').doc().set({
      'doctor': doctor,
      'description' : description,
      'medicines' : medicines,
    }
    );
  }
}