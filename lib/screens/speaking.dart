import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late stt.SpeechToText _speechToText;
  bool _isListening = false;
  String _text = '';
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (status) {
          if (status == 'listening') {
            setState(() => _isListening = true);
          } else if (status == 'notListening') {
            setState(() => _isListening = false);
          }
        },
        onError: (error) {
          print('Error: $error');
        },
      );

      if (available) {
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      _speechToText.stop();
      setState(() => _isListening = false);
    }
  }

  void _sendMessage() {
    setState(() {
      _messages.add(_text);
      _text = '';
    });

void _sendMessage() async {
  String message = _text;
  setState(() {
    _messages.add(message);
    _text = '';
  });

  try {
    var response = await http.post(Uri.parse('https://example.com/api/messages'), body: {'message': message});

    if (response.statusCode == 200) {
      // Message sent successfully
      // Handle the response as needed
    } else {
      // Handle error response
    }
  } catch (e) {
    // Handle network or server error
  }
}

void _checkForNewMessages() async {
  try {
    var response = await http.get(Uri.parse('https://example.com/api/messages'));

    if (response.statusCode == 200) {
      // Parse the response and update the UI with new messages
      // Example:
      // var messages = jsonDecode(response.body);
      // setState(() {
      //   _messages.addAll(messages);
      // });
    } else {
      // Handle error response
    }
  } catch (e) {
    // Handle network or server error
  }
}

    // Add logic here to send the message to the doctor
    // and handle the response accordingly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Doctor'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(_text),
                ),
                IconButton(
                  icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
                  onPressed: _listen,
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
