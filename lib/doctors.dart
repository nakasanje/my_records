import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_records/add.dart';
import 'package:my_records/details.dart';

class DoctorDashboard extends StatefulWidget {
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  List<PatientRecord> patientRecords = [];

  @override
  void initState() {
    super.initState();
    fetchPatientRecords();
  }

  Future<void> fetchPatientRecords() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('patient_records')
            .where('doctor_id', isEqualTo: user.uid)
            .get();

        final patientRecordsData = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return PatientRecord(
            patientName: data['patientName'] as String,
            recordDetails: data['recordDetails'] as String,
            diagnosis: data['diagnosis'] as String,
            treatment: data['treatment'] as String,
          );
        }).toList();

        setState(() {
          patientRecords = patientRecordsData;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PatientRecordSearchDelegate(patientRecords: patientRecords),
              );
            },
          ),
        ],
      ),
      body: patientRecords.isNotEmpty
          ? PatientRecordsPage(patientRecords: patientRecords)
          : Center(child: Text('No patient records found.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewRecordScreen(),
            ),
          ).then((value) {
            // Update the list of patient records after returning from AddNewRecordScreen
            fetchPatientRecords();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PatientRecordsPage extends StatelessWidget {
  final List<PatientRecord> patientRecords;

  PatientRecordsPage({required this.patientRecords});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: patientRecords.length,
      itemBuilder: (context, index) {
        final patientRecord = patientRecords[index];
        return ListTile(
          title: Text(patientRecord.patientName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PatientName: ${patientRecord.patientName}'),
              Text('Record Details: ${patientRecord.recordDetails}'),
              Text('Diagnosis: ${patientRecord.diagnosis}'),
              Text('Treatment: ${patientRecord.treatment}'),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: () {
              // Handle the action for the button
              // For example, request record sharing
              //  //requestRecordSharing(patientRecord);
            },
            child: Text('Request Sharing'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientDetailsScreen(patientRecord: patientRecord),
              ),
            );
          },
        );
      },
    );
  }
}


class PatientRecordSearchDelegate extends SearchDelegate<PatientRecord?> {
  final List<PatientRecord> patientRecords;

  PatientRecordSearchDelegate({required this.patientRecords});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Use 'null' to indicate no patient record was selected
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredPatientRecords = patientRecords
        .where((record) => record.patientName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredPatientRecords.length,
      itemBuilder: (context, index) {
        final patientRecord = filteredPatientRecords[index];
        return ListTile(
          title: Text(patientRecord.patientName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PatientName: ${patientRecord.patientName}'),
              Text('Record Details: ${patientRecord.recordDetails}'),
              Text('Diagnosis: ${patientRecord.diagnosis}'),
              Text('Treatment: ${patientRecord.treatment}'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/details', // Use the correct route name for PatientDetailsScreen
              arguments: patientRecord.toJson(), // Convert the object to JSON
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredPatientRecords = patientRecords
        .where((record) => record.patientName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredPatientRecords.length,
      itemBuilder: (context, index) {
        final patientRecord = filteredPatientRecords[index];
        return ListTile(
          title: Text(patientRecord.patientName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PatientName: ${patientRecord.patientName}'),
              Text('Record Details: ${patientRecord.recordDetails}'),
              Text('Diagnosis: ${patientRecord.diagnosis}'),
              Text('Treatment: ${patientRecord.treatment}'),
            ],
          ),
          onTap: () {
            query = patientRecord.patientName;
          },
        );
      },
    );
  }
}

class PatientRecord {
  final String patientName;
  final String recordDetails;
  final String diagnosis;
  final String treatment;

  PatientRecord({
    required this.patientName,
    required this.recordDetails,
    required this.diagnosis,
    required this.treatment,
  });

  // Add a toJson method to convert the PatientRecord object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'recordDetails': recordDetails,
      'diagnosis': diagnosis,
      'treatment': treatment,
    };
  }
}

