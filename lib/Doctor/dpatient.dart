import 'package:flutter/material.dart';


class PatientDashboard extends StatelessWidget {
  final String email;

  PatientDashboard({required this.email});

  @override
  Widget build(BuildContext context) {
    // Implement the Patient's dashboard UI here based on the 'email' parameter
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Patient $email!'),
      ),
      body: Center(
        child: Text('Welcome, Patient $email!'),
      ),
    );
  }
}
