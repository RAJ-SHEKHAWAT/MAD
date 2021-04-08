import 'package:flutter/material.dart';
import 'package:medhelp/raj/colorsss.dart';
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
  int calories=0;
  int sleep=0;
  int training=0;
  int heartbeat=0;
  addCal(){
    setState(() {
      calories=calories+100;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          CircleAvatar(
            radius: 20.0,
            child: ClipOval(
              child: Image.asset('assets/avatar.png', fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        color: Colors.white,
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
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Heart",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          heartbeat.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Per min",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    heartbeat=heartbeat+10;
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
                                    heartbeat=heartbeat-10;
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
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColor.secondary),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
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
                          onValueChanged: (value) {},
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
                              "2.0",
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
        onPressed: (){},
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
              onPressed: (){},
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