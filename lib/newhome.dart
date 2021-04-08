import 'package:flutter/material.dart';
import 'package:medhelp/form.dart';
import 'package:medhelp/showvisits.dart';
import 'package:medhelp/widget/text_recognition_widget.dart';
class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff9ad7e9),
//        backgroundColor: Colors.transparent,
          title: Text(
            "Medical Zone",
            style: TextStyle(
              color: Colors.black,
            ),
          ),

          bottom: TabBar(
//            labelColor: Colors.purple[100],

            indicatorColor:  Colors.lightBlue,
            tabs: [

              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Medical History",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Prescription Helper",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Prescription Reader",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[200],Colors.blue[50]],
            ),
          ),
//          color: Colors.purple[100],
          child: TabBarView(
            children: [
                ShowVisits(),
                Prescription(),
                TextRecognitionWidget()
            ],
          ),
        ),

      ),
    );
  }
}
