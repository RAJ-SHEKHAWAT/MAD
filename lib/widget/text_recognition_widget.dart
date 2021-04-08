import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:medhelp/api/firebase_ml_api.dart';
import 'package:medhelp/pranav/textToSpeech.dart';
import 'package:medhelp/widget/text_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File image;
  int medicineNameBlock;
  String medicineName2 = "";
  String medicineName1 = "";
  int directionsOfUseBlock = 100000;
  String unitOfMeasure = "";
  String numberOfUnits ="";
  String dayFrequency ="";
  String frequency = "";
  List<dynamic> blocks =[];
   Future<String> recogniseText(File imageFile) async {
    if (imageFile == null) {
      return 'No selected image';
    } else {
      dynamic visionImage = FirebaseVisionImage.fromFile(imageFile);
      dynamic textRecognizer = FirebaseVision.instance.textRecognizer();
      try {
        VisionText visionText = await textRecognizer.processImage(visionImage);
        await textRecognizer.close();
       print(visionText.blocks.elementAt(2).toString());
        String text = extractText(visionText);
        return text.isEmpty ? 'No text found in the image' : text;
      } catch (error) {
        return error.toString();
      }
    }
  }

  Future<String> recogniseImpText(File imageFile) async {
    if (imageFile == null) {
      return 'No selected image';
    } else {
      dynamic visionImage = FirebaseVisionImage.fromFile(imageFile);
      dynamic textRecognizer = FirebaseVision.instance.textRecognizer();
      try {
        VisionText visionText = await textRecognizer.processImage(visionImage);
        await textRecognizer.close();
        print(visionText.blocks.elementAt(2).toString());
        String text = extractImpText(visionText);
        return text.isEmpty ? 'No text found in the image' : text;
      } catch (error) {
        return error.toString();
      }
    }
  }


  String extractText(VisionText visionText) {
//    categorizeBlocks(visionText);
//    String text = "Medicine Name: " + medicineName1 + " " + medicineName2 + "\n" + "Take " + numberOfUnits + " " + unitOfMeasure + " " + frequency + " times " + dayFrequency;
////    text+="Medcine Name:";
////    text+=medicine
////
    String text ="";
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          text = text + word.text + ' ';
        }
        text = text + '\n';
      }
    }

    return text;
  }
  String extractImpText(VisionText visionText) {
    categorizeBlocks(visionText);
    String text = "Medicine Name: " + medicineName1 + " " + medicineName2 + "\n" ;

//    String text ="";
//    for (TextBlock block in visionText.blocks) {
//      for (TextLine line in block.lines) {
//        for (TextElement word in line.elements) {
//          text = text + word.text + ' ';
//        }
//        text = text + '\n';
//      }
//    }

    return text;
  }

  void categorizeBlocks(VisionText visionText) {

    blocks = visionText.blocks;
    if (blocks.isEmpty) {
//    Toast.makeText(this, "No text in image", Toast.LENGTH_SHORT).show();
      print('No text');
    }
    else {
      int i=0;
      for (TextBlock block in visionText.blocks) {
        // System.out.println(blocks.get(i).getText().toString().toLowerCase());
        List<TextLine> paras = block.lines;
        for (TextLine para in paras) {
          List<TextElement> elements = para.elements;
          //System.out.println(elements.get(2).getText());
          for (int k=0;k<elements.length;k++) {
            String word = elements[k].text.toLowerCase().trim();

            if (((word == "take") || (word == "taken")) &&
                (directionsOfUseBlock == 100000)) {
              print("FOUND DIRECTIONS");
              directionsOfUseBlock = i;
//              extractDetails(blocks);
            }
            String mySubstring = null;
            if (word.length > 2) {
              mySubstring = word.substring(word.length - 2, word.length);
            }

            //System.out.println(mySubstring);
            if (word.length > 2 && ((mySubstring.compareTo("mg")) == 0 ||
                (mySubstring.compareTo("ml")) == 0)) {
              print("you should only see this once");
              //System.out.println(word);
              medicineNameBlock = i;
              if (k - 1 > -1) {
                //System.out.println(elements.get(k - 1));
                medicineName2 =  elements[k - 1].text.toString();
                print(medicineName2);

                if (k - 2 > -1) {
                  // System.out.println("med1");
                  medicineName1 = elements[k - 2].text.toString();
                  print(medicineName1);
                }
              }
            }//else if (word.length() > 1 && (word.substring(word.length() - 1, word.length() - 1).equals("g") || (word.substring(word.length() - 1, word.length() - 1).equals("l")))) {
            //medicineNameBlock = i;
          } //System.out.println("Next statement");
        }
        i++;
      }
    }
  }

  void extractDetails(List<TextBlock> blocks) {
    List<TextLine> paras = blocks[directionsOfUseBlock].lines;
    for (int j = 0; j < paras.length; j++) {
      List<TextElement> words = paras[j].elements;

      for (int k = 0; k < words.length; k++) {
        String word = words[k].text.toString().toLowerCase().trim();
        //System.out.println(word);
        print(word+"ye");
        String prevWord = null;
        if (k != 0) {
          prevWord =words[k-1].text.toString().toLowerCase().trim();
        }
        switch (word) {
          case "daily":
          case "weekly":
          case "monthly":
            dayFrequency = word;
            break;
          case "day":
            if (prevWord=="a") {
              dayFrequency = "daily";
            }
            break;
          case "week":
            if (prevWord=="a") {
              dayFrequency = "weekly";
            }
            break;
          case "month":
            if (prevWord=="a") {
              dayFrequency = "monthly";
            }
            break;
          case "once":
          case "time":
            frequency = "1";
            break;
          case "twice":
            frequency = "2";
            break;
          case "thrice":
            frequency = "3";
            break;
          case "times":
            if (checkIfWordNumber(prevWord)) { //checks if its a number spelt out as a word
              frequency = convertWordNumber(prevWord); //converts the word into a number but in string format
            } else if (checkIfNumber(prevWord)) {
              frequency = prevWord;
            }
            break;
          case "tablet":
          case "capsule":
            numberOfUnits = "1";
            unitOfMeasure = word;
            break;
          case "tablets":
            unitOfMeasure = "tablet";
            if (checkIfWordNumber(prevWord)) { //checks if its a number spelt out as a word
              numberOfUnits = convertWordNumber(prevWord); //converts the word into a number but in string format
            } else if (checkIfNumber(prevWord)) {
              numberOfUnits = prevWord;
            }
            break;
          case "capsules":
            unitOfMeasure = "capsule";
            if (checkIfWordNumber(prevWord)) { //checks if its a number spelt out as a word
              numberOfUnits = convertWordNumber(prevWord); //converts the word into a number but in string format
            } else if (checkIfNumber(prevWord)) {
              numberOfUnits = prevWord;
            }
            break;


        }


      }
    }


  }


  bool checkIfWordNumber(String prevWord) {
    switch (prevWord) {
      case "one":
      case "two":
      case "three":
      case "four":
      case "five":
      case "six":
      case "seven":
      case "eight":
      case "nine":
      case "ten":
        return true;
      default:
        return false;
    }
  }

  String convertWordNumber(String prevWord) {
    switch (prevWord) {
      case "one":
        return "1";
      case "two":
        return "2";
      case "three":
        return "3";
      case "four":
        return "4";
      case "five":
        return "5";
      case "six":
        return "6";
      case "seven":
        return "7";
      case "eight":
        return "8";
      case "nine":
        return "9";
      case "ten":
        return "10";
      default:
        return "0"; //check if this is a valid default
    }
  }

  bool checkIfNumber(String prevWord) {
    switch (prevWord) {
      case "1":
      case "10":
      case "9":
      case "8":
      case "7":
      case "6":
      case "5":
      case "4":
      case "3":
      case "2":
        return true;
      default:
        return false;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text("Prescription Reader & Reminder"),),
      body: ListView(
        children: [
          Expanded(child: buildImage()),
          const SizedBox(height: 16),
          ControlsWidget(
            onClickedPickImage: pickImage,
            onClickedScanText: scanText,
            onClickedClear: clear,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextAreaWidget(
              text: text,
              onClickedCopy: copyToClipboard,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Tts(text: text,)));
            }, child: Text("Read Prescription")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {
              scanImpText();
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => Tts(text: text,)));
            }, child: Text("Scan Important details from Image")),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {

            }, child: Text("Set Reminder")),
          )
        ],
      ),
    );
  }
  Widget buildImage() => Container(
    child: image != null
        ? Image.file(image)
        : Icon(Icons.photo, size: 80, color: Colors.black),
  );

  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(file.path));
  }

  Future scanText() async {
    showDialog(
      context: context,

      builder: (_) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    String text = await recogniseText(image);
    setText(text);
    print(text);

    Navigator.of(context).pop();
  }
  Future scanImpText() async {
    showDialog(
      context: context,

      builder: (_) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    String text = await recogniseImpText(image);
    setText(text);
    print(text);

    Navigator.of(context).pop();
  }

  void clear() {
    setImage(null);
    setText('');
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }
}