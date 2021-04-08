import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  String uid="";
  final _formkey = GlobalKey<FormState>();
  String drname='';
  String description='';
  String medicines='';
  String error='';
  void getuser() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    this.uid = user.uid;
  }
  @override
  void initState() {
    getuser();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescription"),
      ),
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
                  validator: (val) => val.isEmpty ? 'This field is necessary' : null,
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
                  validator: (val) => val.isEmpty ? 'This field is necessary' : null,
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
                  validator: (val) => val.isEmpty ? 'This field is necessary' : null,
                  onChanged: (val){
                    setState(() => medicines=val);
                  },
                ),
                SizedBox(height: 20.0),

                ElevatedButton(
//                    color: Colors.pink[400],
                    child: Text("Add"),
                  onPressed: (){},
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

