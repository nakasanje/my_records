import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewRecordScreen extends StatefulWidget {
  const AddNewRecordScreen({Key? key}) : super(key: key);

  @override
  State<AddNewRecordScreen> createState() => _AddNewRecordScreenState();
}

class _AddNewRecordScreenState extends State<AddNewRecordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _recordDetailsController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _treatmentController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final patientData = {
        'patientName': _patientNameController.text,
        'recordDetails': _recordDetailsController.text,
        'diagnosis': _diagnosisController.text,
        'treatment': _treatmentController.text,
      };

      // Add the patient data to Firestore
      FirebaseFirestore.instance.collection('patient_records').add(patientData);

      // Clear the text fields after adding the patient
      _patientNameController.clear();
      _recordDetailsController.clear();
      _diagnosisController.clear();
      _treatmentController.clear();

      // Show a success message or navigate back to the DoctorDashboard
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Patient added successfully')),
      );
        // Navigate back to the DoctorDashboard
    Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _patientNameController,
                decoration: InputDecoration(labelText: 'Patient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _recordDetailsController,
                decoration: InputDecoration(labelText: 'Record Details'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the record details';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _diagnosisController,
                decoration: InputDecoration(labelText: 'Diagnosis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the diagnosis';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _treatmentController,
                decoration: InputDecoration(labelText: 'Treatment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the treatment';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Patient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Patient {
  String patientName;
  String recordDetails;
  String diagnosis;
  String treatment;

  Patient({
    required this.patientName,
    required this.recordDetails,
    required this.diagnosis,
    required this.treatment,
  });

  Map<String, dynamic> toJson() {
    return {
      'patient_name': patientName,
      'record_details': recordDetails,
      'diagnosis': diagnosis,
      'treatment': treatment,
      // Add more properties as needed
    };
  }
}


