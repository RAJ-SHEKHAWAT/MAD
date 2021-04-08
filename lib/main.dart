import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medhelp/newhome.dart';
import 'package:medhelp/pranav/textToSpeech.dart';
import 'package:medhelp/raj/home.dart';
import 'package:medhelp/showvisits.dart';
import 'package:medhelp/widget/text_recognition_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'form.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Text Recognition';

  @override

  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "title",
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    home: SignInPage(),
  );
}
Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class SignInPage extends StatefulWidget {


  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isSigned=false;
  isLoggedIn() {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isSigned = false;
        });
        return;
      } else {
        User user = FirebaseAuth.instance.currentUser;

//      if (!user.emailVerified) {
//        await user.sendEmailVerification();
//        SignOut();
//        return;
//      }
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
//        currentUser = CurrentUser.fromDocument(documentSnapshot);
        print(user.uid);
        print('User is signed in!');
        setState(() {
          isSigned = true;
        });
      }
    });
  }

  signIn() async{
    try{
    UserCredential userCredential = await signInWithGoogle();}
    catch(e){
      print("error: " + e.toString());
      return;
    }

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).get();
    if(documentSnapshot.exists){
      setState(() {
        isSigned=true;
      });
    }
    else
      {
       User user = await FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "name" : user.displayName,
          "email" : user.email,
          "profilePic" : user.photoURL,
          "uid" :user.uid,
           "contact " :"",
          "address" : ""
        });
        setState(() {
          isSigned=true;
        });
      }


  }
  @override
  void initState() {
    // TODO: implement initState
    isLoggedIn();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isSigned?MainPage(title: "Health Bloom"):Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              OutlineButton(
                splashColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage("assets/google_logo.png"),
                          height: 35.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                 signIn();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}






class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  signout() async{
    await GoogleSignIn().signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text(widget.title),
      actions: [
        ElevatedButton(onPressed: (){
          FirebaseAuth.instance.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
        }, child: Text("Sign Out")),
      ],
    ),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [Colors.blue[200],Colors.blue[50]],
        ),
      ),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 200,

          ),

          Padding(
            padding:   EdgeInsets.fromLTRB(100, 10, 100, 10),
            child: RaisedButton(
              textColor: Colors.teal,
              color: Colors.white,
              child: Text("Fitness Zone",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RHome()));
              },
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            ),
          ),
//          SizedBox(
//            height: 10.0,
//          ),
          Padding(
            padding:  EdgeInsets.fromLTRB(100, 10, 100, 10),
            child: RaisedButton(
              textColor: Colors.teal,
              color: Colors.white,
              child: Text("Medical Zone",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewHome()));

              },
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            ),
          ),









        ],
      ),



    ),
  );
}