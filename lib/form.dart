import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:medhelp/api/firebase_ml_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
  bool isSubmitted = false;
  bool isLoading;
  User user;
  bool _loadingPath = false;
  List<PlatformFile> _paths;
  String presctext="";
  FileType _pickingType = FileType.any;
  String _directoryPath;
  String fileName;
  bool isLate = false;
  String _extension;
  bool _multiPick = false;
  String userAssignmentUrl = "";
  DateTime userSubmissionTime;
  String userFileName = "";
  String userGrade = "";
  String url="";
  Future getFileAndUpload() async {
//    FilePickerResult result;
//    try {
//      _directoryPath = null;
//     result = await FilePicker.platform.pickFiles();
//    } on PlatformException catch (e) {
//      print("Unsupported operation" + e.toString());
//    } catch (ex) {
//      print(ex);
//    }
//    if (!mounted) return;
//    List<int> bytes;
//    if(result != null) {
//      PlatformFile file = result.files.first;
//      bytes = file.bytes;
//      print(file.name);
//      print(file.bytes);
//      print(file.size);
//      print(file.extension);
//      print(file.path);
//      Uint8List data = Uint8List.fromList(bytes);
//      SnackBar snackBar =
//      SnackBar(content: Text("Uploading Your Prescription....."));
//      ScaffoldMessenger.of(context).showSnackBar(snackBar);
//      File filee  =File.fromRawPath(data);
//      presctext= await FirebaseMLApi.recogniseText(filee);
//      Upload(fileName, data);
//    }

    dynamic imgFile = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,

    );
//    List<File> images = [];

    File file = File(imgFile);
//    presctext=await FirebaseMLApi.recogniseText(file);
    Upload(userSubmissionTime.toString(), file);
    setState(() {
      _loadingPath = false;

//      _paths != null ? _paths.map((e) => fileName = e.name).toString() : '...';

//      _paths != null ? _paths.map((e) => {bytes = e.bytes}).toString() : '...'


    });
  }

  Upload(fileName, dynamic data) async {
    setState(() => _loadingPath = true);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(
        'usersdata/${user.uid}/${userSubmissionTime}/${fileName}');
    _extension = fileName.toString().split('.').last;
    firebase_storage.SettableMetadata metadata =
    firebase_storage.SettableMetadata(
        contentType: '$_pickingType/$_extension');

    try {
      await ref.putFile(data, metadata);
      String downloadURL = await ref.getDownloadURL();
      print(downloadURL);
//      storeToFirestore(downloadURL, fileName);
      setState(() {
        url=downloadURL;
        _loadingPath = false;
      });
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);

    }
    setState(() {
      _loadingPath=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    user=FirebaseAuth.instance.currentUser;
    userSubmissionTime=DateTime.now();
    super.initState();
  }
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

                _loadingPath?Center(child: CircularProgressIndicator(),) :   ElevatedButton(
//                    color: Colors.pink[400],
                    child: Text("Upload Prescription"),
                    onPressed: (){
                      print(drname);
                      print(description);
                      print(medicines);
//                      if(key.currentState.validate()){
//                      DatabaseService(uid: user.uid).adddata(drname, description, medicines);
//                      Navigator.pop(context);
                      getFileAndUpload();
//                      }
                    }

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
                      DatabaseService(uid: user.uid).adddata(doctor: drname,description: description,medicines: medicines,url: url,prescText: presctext,date: userSubmissionTime);
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
