import 'package:flutter/material.dart';
import 'package:homerex/screens/editpro.dart';
import 'package:homerex/screens/speak.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:homerex/screens/speaking.dart';
import 'package:homerex/screens/patientsrecord.dart';
import 'package:homerex/screens/reportsymptom.dart';
import 'package:homerex/screens/reportsymptom.dart';




class PatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Screen'),
      ),
      backgroundColor: const Color.fromARGB(255, 198, 238, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, Patient!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () { Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HealthTrackingWidget()),
                );
                // Add patients as children
              },
              child: Text('track'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Open chat
              },
              child: Text('Open Chat'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Monitor statistics
              },
              child: Text('Call'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
               onPressed: () async {
    const url = 'https://paystack.com/pay/bookdoctor';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  },
  child: Text('Book Appointment'),
),
SizedBox(height:16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SymptomReportingWidget()),
                );
                // Add patients as children
              },
              child: Text('view'),
            ),
  SizedBox(height:16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ChatWidget()),
                );
                // Add patients as children
              },
              child: Text('speak'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfileScreen()),
                );
                // Add patients as children
              },
              child: Text('Edit profile'),
            ),
            //  SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>  VoiceToTextWidget()),
            //     );
            //     // Add patients as children
            //   },
            //   child: Text('voice 2'),
            // ),
          ],
        ),
      ),
    );
  }
}
