
// import 'package:flutter/material.dart';

// class VoiceToTextWidget extends StatelessWidget {
//   final Function(String) onTextCaptured;

//   VoiceToTextWidget({required this.onTextCaptured});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             'Voice-to-Text',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               // Simulate voice-to-text functionality
//               String capturedText = 'This is an example of voice-to-text.';
//               onTextCaptured(capturedText);
//             },
//             child: Text('Capture Text'),
//           ),
//         ],
//       ),
//     );
//   }
// }
