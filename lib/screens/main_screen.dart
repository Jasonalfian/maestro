import 'dart:io' as DartIO;
import 'package:flutter/material.dart';
import 'package:maestro/components/constants.dart';
import 'package:maestro/components/rounded_button.dart';
import 'package:maestro/services/result.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

const List<String> sumResult = [
  '50 words',
  '100 words',
  '150 words',
  '200 words',
  '250 words',
  '300 words'
];

class _MainScreenState extends State<MainScreen> {
  FlutterTts flutterTts;

  String input;
  String result = "first try";
  String tempResult;
  int sumShowResult = 50;
  bool isSpeak = false;
  bool showSpinner= false;
  bool isFirst=true;
  var listString;
  GenerateLyrics generateLyrics = GenerateLyrics();

  void updateUI(dynamic resultData) {
    setState(() {
      if(resultData==null){
        result="There's been an error, please try again.";
        return;
      }
      result = input + " " + resultData['generated_text'];
      isFirst = false;
      listString = result.split(' ');
      tempResult = concatString(sumShowResult, listString);
    });
  }

  void updateUIByPicker(int sumShow){
    setState(() {
      tempResult = concatString(sumShow,listString);
    });
  }

  String concatString(int sum, var list){
    String mix = "";
    for(int i=0;i<sum;i++){
      if(i==0){
        mix=mix+"${list[0]}";
      }
      mix=mix+" ${list[i]}";
    } return mix;
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Color(0xff8269E8),
      itemExtent: 20.0,
      onSelectedItemChanged: (selectedIndex) async {
        print(selectedIndex);
        sumShowResult=(50*selectedIndex)+50;
        if(isFirst){
          print('do nothing');
        } else {
          updateUIByPicker(sumShowResult);
        }
      },
      children: getPickerItems(),
    );
  }

  List<Text> getPickerItems() {
    List<Text> pickerItems = [];
    for (String option in sumResult) {
      pickerItems.add(Text(
        option,
        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ));
    }
    return pickerItems;
  }

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Future _speak() async {
    if (result != null) {
      if (result.isNotEmpty) {
        await flutterTts.setVolume(1.0);
        await flutterTts.setSpeechRate(0.4);
        await flutterTts.setPitch(1.0);

        if (DartIO.Platform.isIOS) {
          await flutterTts.setSharedInstance(false);
        }

        await flutterTts.speak(tempResult);
      }
    }
  }

  Future _stop() async{
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Color(0xff8269E8),
      progressIndicator: CircularProgressIndicator(backgroundColor: Color(0xff8269E8)),
      opacity: 0.3,
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff8269E8),
          title: Text(
            'Insane Maestro',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'NunitoSans',
                fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bgmain.png"), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Container(
              constraints: BoxConstraints.expand(),
              child: Padding(
                padding: EdgeInsets.only(left: 20,right: 20,top: 35,bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              width: 330,
                              height: 30,
                              child: Text(
                                "Hey, let's make your song's lyrics!",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                textAlign: TextAlign.left,
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  flex: 5,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      input=value;
                                    },
                                    style: TextStyle(color: Colors.black),
                                    decoration: kTextFieldDecoration.copyWith(
                                        hintText: 'Input your text'
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: RoundedButton(
                                    colour: Color(0xff8269E8),
                                    size: 15,
                                    title: 'Start',
                                    normal: false,
                                    onPressed: () async{
                                      if(input!=null) {
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        var rawResult = await generateLyrics
                                            .getLyrics(input, 300);
                                        updateUI(rawResult);
                                        setState(() {
                                          showSpinner = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              width: 330,
                              height: 35,
                              child: Text(
                                "Here's your lyrics!",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                textAlign: TextAlign.left,
                              )),
                          Container(
                            height: 310,
                            width: 330,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff8269E8), width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: isFirst ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Opacity(
                                  opacity: 0.5,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage("images/logobaru2.gif"),
                                  ),
                                )
                              ],
                            ) : SelectableText(
                              tempResult, textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                height: 55,
                                width: 330,
                                child: RoundedButton(
                                  colour: Color(0xff8269E8),
                                  title: isSpeak ? 'Stop' : 'Speak',
                                  size: 16,
                                  normal: true,
                                  onPressed: () async{
                                    isSpeak ? _stop() : _speak();
                                    setState(() {
                                      isSpeak = !isSpeak;
                                    });
                                  },
                                ),
                              ),
                              Container(height: 10),
                              Center(
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xff8269E8), width: 2.0),
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: iOSPicker(),
                                ),
                              ),
                              Container(height: 16),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
