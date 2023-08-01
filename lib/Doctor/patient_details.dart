import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:homerex/Doctor/dashboard.dart';

class PatientsPage extends StatefulWidget {
  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  List<Patient> patients = []; // List to store the patient data

  @override
  void initState() {
    super.initState();
    // Fetch the patient data and populate the 'patients' list
    fetchPatients();
  }

 Future<void> fetchPatients() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('patients').get();
    List<Patient> fetchedPatients = snapshot.docs.map((doc) {
      var data = doc.data();
      return Patient(
        id: doc.id,
        name: data['name'],
        age: data['age'],
          labTests: [], // Initialize with an empty list for lab tests

      );
    }).toList();

    setState(() {
      patients = fetchedPatients;
    });
  } catch (e) {
    print('Error fetching patients: $e');
    // Handle error, e.g., show a Snackbar
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return ListTile(
            title: Text(patient.name),
            subtitle: Text('Age: ${patient.age}'),
            onTap: () {
              // Navigate to patient details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientDetailsPage(patient: patient),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PatientDetailsPage extends StatelessWidget {
  final Patient patient;

   PatientDetailsPage({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${patient.name}'),
            Text('Age: ${patient.age}'),

            // Display other patient details as needed
            // For example, you can display lab tests here:
            ListView.builder(
              shrinkWrap: true,
              itemCount: patient.labTests.length,
              itemBuilder: (context, index) {
                final labTest = patient.labTests[index];
                return ListTile(
                  title: Text('Lab Test Name: ${labTest.testName}'),
                  subtitle: Text('Result: ${labTest.result}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



