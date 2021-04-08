import 'package:flutter/material.dart';

class Profileuser extends StatefulWidget {
  @override
  _ProfileuserState createState() => _ProfileuserState();
}

class _ProfileuserState extends State<Profileuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('MY Profile'),
      ),
      body: Container(
        child:Column(
          children: [
            Expanded(child: Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: boxdeco(),
                  child: Column(
                    children: [
                      Icon(Icons.format_indent_increase),
                      Text('Your Initial heath'),
                      Text('45'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: (){
                                // setState(() {
                                //   calories=calories+100;
                                // });
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
                                // setState(() {
                                //   calories=calories-100;
                                // });
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
                )),
                Expanded(child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: boxdeco(),
                  child: Column(
                    children: [
                      Icon(Icons.format_indent_increase),
                      Text('Your Initial heath'),
                      Text('45'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: (){
                                // setState(() {
                                //   calories=calories+100;
                                // });
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
                                // setState(() {
                                //   calories=calories-100;
                                // });
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
                )),
              ],
            )
            ),
            Expanded(child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: boxdeco(),
              child:Text('your progress is goood'),
            )),
            Expanded(child: Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: boxdeco(),
                  child: Text('increasing'),
                )),
                Expanded(child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: boxdeco(),
                  child: Text('increasing'),
                )),
              ],
            )
            ),
            Expanded(child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: boxdeco(),
              child: Text('you are ahead of your target'),
              // child: Text('your progress is goood'),
            )),

          ],
        )
      ),
    );
  }
  BoxDecoration boxdeco() {
    return BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange[100],
    );
  }
}
