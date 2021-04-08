import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';



class Tts extends StatefulWidget {
  String text = "";
  Tts({this.text});
  @override
  _MyAppState createState() => _MyAppState();
}

enum TtsState { playing, stopped }

class _MyAppState extends State<Tts> {
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 1;
  double pitch = 1.4;
  double rate = 0.7;
  TextEditingController txt=TextEditingController();
  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    setState(() {
      _newVoiceText=widget.text;
      txt.text=widget.text;
      _speak();
    });

    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    print("Available languages ${languages}");
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    for (String type in languages) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language);
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            bottomNavigationBar: bottomBar(),
            appBar: AppBar(
              title: Text('Prescription Speech',),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
//                  _inputSection(),
                  Text("Set Language"),
                  languages != null ? _languageDropDownSection() : Text(""),
                  _buildSliders(),

                  Card(
                    elevation: 12.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(widget.text),
                    ),
                  ),

                ])));
  }

  Widget _inputSection() => Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: txt,
        onChanged: (String value) {
          _onChange(value);
        },
      ));



  Widget _languageDropDownSection() => Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: language,
          items: getLanguageDropDownMenuItems(),
          onChanged: changedLanguageDropDownItem,
        )
      ]));


  Widget _buildSliders() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text("Set Volume"),
        ),
        _volume(),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text("Set Pitch"),
        ),
        _pitch(),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text("Set Rate"),
        ),
        _rate()],

    );
  }

  Widget _volume() {
    return Slider(
        value: volume,
        onChanged: (newVolume) {
          setState(() => volume = newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Volume: $volume");
  }

  Widget _pitch() {
    return Slider(
      value: pitch,
      onChanged: (newPitch) {
        setState(() => pitch = newPitch);
      },
      min: 0.5,
      max: 2.0,
      divisions: 15,
      label: "Pitch: $pitch",
      activeColor: Colors.red,
    );
  }

  Widget _rate() {
    return Slider(
      value: rate,
      onChanged: (newRate) {
        setState(() => rate = newRate);
      },
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: "Rate: $rate",
      activeColor: Colors.green,
    );
  }

  bottomBar() =>Container(
    margin: EdgeInsets.all(10.0),
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton(
          onPressed: _speak,
          child: Icon(Icons.play_arrow),
          backgroundColor: Colors.green,

        ),

        FloatingActionButton(
          onPressed: _stop,
          backgroundColor: Colors.red,
          child: Icon(Icons.stop),
        ),
      ],
    ),
  );
}









