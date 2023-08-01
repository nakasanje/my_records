import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:homerex/Doctor/dashboard.dart';


class AddPatientPage extends StatefulWidget {
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final _formKey = GlobalKey<FormState>();
  String?_id;
  String? _name;
  int? _age;
  List<LabTest> _labTests = []; // List to store lab test information

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create a new Patient object with the entered information
      Patient newPatient = Patient(
        id: _id!,
        name: _name!,
        age: _age!,
        labTests: _labTests!, // Include the lab test information
      );

      // Save the new patient record to Cloud Firestore
      try {
        await FirebaseFirestore.instance
            .collection('patients')
            .add(newPatient.toJson());

        // Provide feedback to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Patient added successfully')),
        );

        // Navigate back to the patient list or details page
        Navigator.pop(context);
      } catch (e) {
        // Handle any errors that occur during saving
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add patient')),
        );
        print(e);
      }
    }
  }

  void _addLabTest() {
    setState(() {
      // Add a new lab test to the list
      _labTests.add(LabTest(testName: '', result: ''));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  // Validate that the age is a valid integer
                  try {
                    int.parse(value);
                  } catch (e) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _age = int.tryParse(value);
                  });
                },
              ),
              // Display form fields for lab test information
              ..._labTests.map((test) => _buildLabTestForm(test)).toList(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addLabTest,
                child: Text('Add Lab Test'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add & Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabTestForm(LabTest labTest) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Test Name'),
          initialValue: labTest.testName,
          onChanged: (value) {
            setState(() {
              labTest.testName = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Result'),
          initialValue: labTest.result,
          onChanged: (value) {
            setState(() {
              labTest.result = value;
            });
          },
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}


