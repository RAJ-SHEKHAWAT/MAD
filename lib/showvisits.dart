import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShowVisits extends StatefulWidget {
  @override
  _ShowVisitsState createState() => _ShowVisitsState();
}

class _ShowVisitsState extends State<ShowVisits> {
  User user;
  CollectionReference prescription;
  getUser(){
    user = FirebaseAuth.instance.currentUser;
    prescription= FirebaseFirestore.instance.collection("prescription");
  }
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Your Sittings"),
//      ),
      body: StreamBuilder(
          stream: prescription.doc(user.uid).collection('pres').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView(
              children: snapshot.data.docs.map(
                    (document) {
                  return ListTile(
                    title: Text(document['doctor']),
                    onTap: (){

                    },
                  );
                },
              ).toList(),
            );
          }),
    );
  }
}
