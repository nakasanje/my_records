import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  List<String> patientRecords = [];

  @override
  void initState() {
    super.initState();
    fetchPatientRecords();
  }

  Future<void> fetchPatientRecords() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('patient_records')
          .where('doctor_id', isEqualTo: user.uid)
          .get();
      setState(() {
        patientRecords =
            snapshot.docs.map((doc) => doc['patient_name'] as String).toList();
      });
    }
  }

  Future<void> requestRecordSharing(String patientId, String recordId) async {
    try {
      await FirebaseFirestore.instance
          .collection('patient_records')
          .doc(recordId)
          .update({'sharing_requested': true});

      // Send a notification or perform any other necessary action to inform the patient
    } catch (e) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Patient Records:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            if (patientRecords.isEmpty) const Text('No patient records found.'),
            Expanded(
              child: ListView.builder(
                itemCount: patientRecords.length,
                itemBuilder: (context, index) {
                  final patientName = patientRecords[index];
                  return ListTile(
                    title: Text(patientName),
                    trailing: ElevatedButton(
                      onPressed: () {
                        String patientId = ''; // Get the patient's ID
                        String recordId = ''; // Get the record's ID
                        requestRecordSharing(patientId, recordId);
                      },
                      child: const Text('Request Sharing'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
