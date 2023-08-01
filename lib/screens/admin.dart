import 'package:flutter/material.dart';
import 'package:homerex/screens/addemployee.dart';
import 'package:homerex/screens/editpro.dart';
import 'package:homerex/screens/empolyeeinput.dart';
import 'package:homerex/screens/phone.dart';
import 'package:homerex/screens/selection.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Color.fromARGB(255, 0, 148, 148),
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/hos.png'),
            radius: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, Admin!',
              style: TextStyle(fontSize: 24),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SelectionPage()),
                );
              },
              icon: const Icon(Icons.logout),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // View patient records
              },
              child: Text('View Employee Records'),
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
                            phoneNumber: '',
                          )),
                );
                // Monitor statistics
              },
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Adjust the value as per your needs
                ),
                backgroundColor: const Color(0xFF018C97),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              child: Text('Call'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const InputEmp()),
                );
                // Add patients as children
              },
              child: Text('Add  Employee'),
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
