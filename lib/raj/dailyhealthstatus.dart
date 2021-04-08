import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HealthdailyStatus extends StatefulWidget {
  @override
  _HealthdailyStatusState createState() => _HealthdailyStatusState();
}

class _HealthdailyStatusState extends State<HealthdailyStatus> {
  User user;
  CollectionReference userRef;
  getUser()async{
    user = await FirebaseAuth.instance.currentUser;
    userRef= await FirebaseFirestore.instance.collection("Home");
  }
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Daily Health Status'),
      ),
      body: Container(
        child: StreamBuilder(
            stream: userRef.doc(user.uid).collection('daily').snapshots(),
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

                    return Container(
                      child: Column(
                        children: [
                          Text(document['calories'].toString()),
                        ],
                      ),
                    );
                  },
                ).toList(),
              );
            }),
      ),
    );
  }
}
