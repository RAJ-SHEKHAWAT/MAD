import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';

class Prescription extends StatefulWidget {
  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  String uid="";
  final _formkey = GlobalKey<FormState>();
  String drname='';
  String description='';
  String medicines='';
  String error='';
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Prescription"),
//      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                    focusColor: Colors.grey,
                    hintText: 'Doctor\'s Name',
                  ),
                  validator: (val) => val.isEmpty ? 'This is necessary Field' : null,
                  onChanged: (val){
                    setState(() => drname=val);
                  },
                ),

                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                    focusColor: Colors.grey,
                    hintText: 'Description',
                  ),
                  validator: (val) => val.isEmpty ? 'Add a description' : null,
                  onChanged: (val){
                    setState(() => description=val);
                  },
                ),


                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                    focusColor: Colors.grey,
                    hintText: 'Medicines',
                  ),
                  validator: (val) => val.isEmpty ? 'Necessary Field' : null,
                  onChanged: (val){
                    setState(() => medicines=val);
                  },
                ),
                SizedBox(height: 20.0),

                ElevatedButton(
//                    color: Colors.pink[400],
                    child: Text("Add"),
                    onPressed: (){
                      print(drname);
                      print(description);
                      print(medicines);
//                      if(key.currentState.validate()){
                         DatabaseService(uid: user.uid).adddata(drname, description, medicines);
                        Navigator.pop(context);
//                      }
                    }

                ),
                SizedBox(height: 20.0),
                Text(error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),

        ],

      ),
    );
  }
}
