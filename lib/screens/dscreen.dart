import 'package:flutter/material.dart';
import 'package:homerex/screens/editpro.dart';
//import 'package:homerex/screens/records.dart';


class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, Doctor!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // View patient records
              },
              child: Text('View Patient Records'),
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
              child: Text('Monitor Statistics'),
            ),
            //SizedBox(height: 16),
            //ElevatedButton(
              //onPressed: () {
                //Navigator.pushReplacement(
                  //context,
                  //MaterialPageRoute(
                    //  builder: (context) => AddPatientRecordPage ()),
                //);
                // Add patients as children
              //},
              //child: Text('record'),
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
