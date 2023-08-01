import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeakingAssistant extends StatefulWidget {
  @override
  _SpeakingAssistantState createState() => _SpeakingAssistantState();
}

class _SpeakingAssistantState extends State<SpeakingAssistant> {
  FlutterTts flutterTts = FlutterTts();
  String textToSpeak = 'Hello, how can I assist you?';

  @override
  void initState() {
    super.initState();
    initTts();
  }

  Future<void> initTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.setVolume(1.0);
    await flutterTts.isLanguageAvailable('en-US');
  }

  Future<void> speakText() async {
    await flutterTts.speak(textToSpeak);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speaking Assistant'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: speakText,
              child: Text('Speak'),
            ),
          ],
        ),
      ),
    );
  }
}
