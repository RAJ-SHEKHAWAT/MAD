import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medhelp/raj/Profile.dart';
import 'package:medhelp/raj/colorsss.dart';
import 'package:medhelp/raj/dailyhealthstatus.dart';
import 'package:medhelp/raj/linechart.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

//this class if for home screen
//lets continue

class RHome extends StatefulWidget {
  @override
  _RHomeState createState() => _RHomeState();
}

class _RHomeState extends State<RHome> {
  @override
  int walk=0;
  int calories=0;
  int sleep=0;
  int training=0;
  int cintake=0;
  int Tcalories=0;
  addDailyHealthRecord()async{
    CollectionReference users = FirebaseFirestore.instance.collection('Home');
    User user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    // if (!documentSnapshot.exists) {
      users.doc(user.uid).collection('daily').doc().set({
        "walk":walk,
        "calories":calories,
        "sleep": sleep,
        "training":training,
        "cintake":cintake,
      });

    // }
  }
  User user;
  CollectionReference userRef;
  getUser(){
    user = FirebaseAuth.instance.currentUser;
    userRef= FirebaseFirestore.instance.collection("Home");
  }
  getData()async{
    await userRef.doc(user.uid).get().then((dataa){
      if (dataa.data().containsKey('Tcalories')){
        if(dataa['Tcalories']!=null){
          Tcalories=dataa['Tcalories'];
        }
      }
    });
  }
  setData()async{
    await userRef.doc(user.uid).update({
      "Tcalories":Tcalories,
    });
  }
  void initState() {
    getUser();
    getData();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profileuser()));
            },
            child: CircleAvatar(
              radius: 20.0,
              child: ClipOval(
                child: Image.asset('assets/avatar.png', fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(


        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Today"),
                  Text(
                    "April 08, 2021",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.deepOrange),
                          child: Icon(
                            Icons.fastfood,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Food",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          cintake.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "in calories",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    cintake=cintake+100;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[200],
                                    ),
                                    child: Icon(Icons.add))
                            ),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    cintake=cintake+100;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[200],
                                    ),
                                    child: Icon(Icons.remove))
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // padding: EdgeInsets.symmetric(vertical: 20),
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: MyColor.secondary),
                      //   borderRadius: BorderRadius.all(Radius.circular(30)),
                      // ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: MyColor.primary),
                            child: Icon(
                              Icons.local_fire_department_sharp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Calories",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            calories.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Kcal",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      calories=calories+100;
                                    });
                                  },
                                  child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[200],
                                ),
                                  child: Icon(Icons.add))
                              ),
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      calories=calories-100;
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[200],
                                      ),
                                      child: Icon(Icons.remove))
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orangeAccent),
                          child: Icon(
                            Icons.nightlight_round,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Sleep",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          sleep.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Hours",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    sleep=sleep+1;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[200],
                                    ),
                                    child: Icon(Icons.add))
                            ),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    sleep=sleep-1;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[200],
                                    ),
                                    child: Icon(Icons.remove))
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.deepPurple),
                          child: Icon(
                            Icons.timer_sharp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Training",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          training.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Hours",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    training=training+1;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[200],
                                    ),
                                    child: Icon(Icons.add))
                            ),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    training=training-1;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[200],
                                    ),
                                    child: Icon(Icons.remove))
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              width: 200,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    axisLineStyle: AxisLineStyle(
                        thickness: 0.2,
                        thicknessUnit: GaugeSizeUnit.factor,
                        cornerStyle: CornerStyle.bothCurve),
                    showTicks: false,
                    showLabels: false,
                    onAxisTapped: (value) {},
                    pointers: <GaugePointer>[
                      RangePointer(
                          color: MyColor.secondary,
                          value: 60,
                          onValueChanged: (value) {
                            setState(() {
                              walk=value.toInt();
                            });
                          },
                          cornerStyle: CornerStyle.bothCurve,
                          onValueChangeEnd: (value) {},
                          onValueChanging: (value) {},
                          enableDragging: true,
                          width: 0.2,
                          sizeUnit: GaugeSizeUnit.factor)
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              walk.toString(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "KM",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        positionFactor: 0.13,
                        angle: 0.5,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              transform: Matrix4.translationValues(0.0, -60, 0.0),
              child: Image.asset('assets/marathon.png'),
            ),

            //here is the chart
            //lets make new statefull widget
            //now lets move chart a little bit

            //we are done.
            //thanks for watching :)

            Container(
              transform: Matrix4.translationValues(0.0, -60, 0.0),
              child: MyLineChart(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColor.secondary,
        onPressed: (){
          addDailyHealthRecord();
          Tcalories=cintake-sleep*46+calories;
          setData();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: MyColor.primary,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              color: Colors.white,
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.add_chart),
              color: Colors.white,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HealthdailyStatus()));
              },
            ),
            SizedBox(width: 50,),
            IconButton(
              icon: Icon(Icons.favorite_border),
              color: Colors.white,
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: Colors.white,
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}