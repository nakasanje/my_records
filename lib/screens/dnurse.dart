import 'package:flutter/material.dart';
import 'package:homerex/screens/editpro.dart';
import 'package:homerex/screens/phone.dart';

class NurseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nurse Dashboard'),
      ),
      backgroundColor: const Color.fromARGB(255, 198, 238, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, Nurse!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // View patient records
              },
              child: Text('View patient Records'),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CallButton(
                            phoneNumber: '0773078427',
                          )),
                );
                // Monitor statistics
              },
              child: Text('Call'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add patients as children
              },
              child: Text('Patient Record'),
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
          ],
        ),
      ),
    );
  }
}
