import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:homerex/Doctor/dashboard.dart';



class EditPatientPage extends StatefulWidget {
    final Patient patient; // Now the Patient class should be recognized

  EditPatientPage({required this.patient});


  @override
  _EditPatientPageState createState() => _EditPatientPageState();
}

class _EditPatientPageState extends State<EditPatientPage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  int? _age;
  // Add other patient fields as required

  @override
  void initState() {
    super.initState();
    // Pre-fill the form fields with the patient's current information
    _name = widget.patient.name;
    _age = widget.patient.age;
    // Set other patient fields accordingly
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Update the patient's information in the database or API
      // using the values from the form fields
      // ...
      // Navigate back to the patient details page or any other desired page
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
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
              // Add other form fields as required
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}