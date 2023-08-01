import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:homerex/Doctor/dashboard.dart';

import 'package:homerex/Doctor/add.dart';




class PatientDetailsPage extends StatelessWidget {
  final Patient patient;

  PatientDetailsPage({required this.patient});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Name: ${patient.name}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Age: ${patient.age}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: patient.labTests.length,
              itemBuilder: (context, index) {
                final labTest = patient.labTests[index];
                return ListTile(
                  title: Text('Test: ${labTest.testName}'),
                  subtitle: Text('Result: ${labTest.result}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// class PatientsPage extends StatefulWidget {
//   @override
//   _PatientsPageState createState() => _PatientsPageState();
// }

// class _PatientsPageState extends State<PatientsPage> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   List<Patient> patients = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchPatients();
//   }

//   Future<void> fetchPatients() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance.collection('patients').get();

//       final patientsData = snapshot.docs.map((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         List<LabTest> labTests = data['labTests'] != null
//             ? (data['labTests'] as List)
//                 .map((testData) => LabTest(
//                       testName: testData['testName'] as String,
//                       result: testData['result'] as String,
//                     ))
//                 .toList()
//             : [];

//         return Patient(
//           name: data['name'] as String,
//           age: data['age'] as int,
//           labTests: labTests,
//         );
//       }).toList();

//       setState(() {
//         patients = patientsData;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: patients.length,
//       itemBuilder: (context, index) {
//         final patient = patients[index];
//         return ListTile(
//           title: Text(patient.name),
//           subtitle: Text('Age: ${patient.age}'),
//           onTap: () {
//             // Navigate to patient details page and pass the patient object
//             Navigator.pushNamed(
//               context,
//               'patientDetails',
//               arguments: patient,
//             );
//           },
//         );
//       },
//     );
//   }
// }
