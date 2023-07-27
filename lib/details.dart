
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_records/add.dart';
import 'package:my_records/doctors.dart';


class PatientDetailsScreen extends StatelessWidget {
  final PatientRecord patientRecord;

  PatientDetailsScreen({required this.patientRecord});

  @override
  Widget build(BuildContext context) {
    // Build the screen to display all the details of the patient record.
    // You can use patientRecord to get the details and display them in the UI.
    // You may use a ListView, Card, or any other widget to organize the information.
    // For example:
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('PatientName: ${patientRecord.patientName}'),
            Text('recordDetails: ${patientRecord.recordDetails}'),
            Text('Diagnosis: ${patientRecord.diagnosis}'),
            Text('Treatment: ${patientRecord.treatment}'),
            // Add other patient details here.
          ],
        ),
      ),
    );
  }
}


