import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/src/datetime_picker_theme.dart' as picker;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class PatientRecord {
  final String patientName;
  final String medicalHistory;
  final String symptoms;
  final String diagnoses;
  final String treatments;
  final DateTime dateTime;

  PatientRecord({
    required this.patientName,
    required this.medicalHistory,
    required this.symptoms,
    required this.diagnoses,
    required this.treatments,
    required this.dateTime,
  });
}

class AddPatientRecordPage extends StatefulWidget {
  @override
  _AddPatientRecordPageState createState() => _AddPatientRecordPageState();
}

class _AddPatientRecordPageState extends State<AddPatientRecordPage> {
  final _formKey = GlobalKey<FormState>();
  late String _patientName;
  late String _medicalHistory;
  late String _symptoms;
  late String _diagnoses;
  late String _treatments;
  late DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Patient Record'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Patient Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the patient name';
                }
                return null;
              },
              onSaved: (value) {
                _patientName = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Medical History'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the medical history';
                }
                return null;
              },
              onSaved: (value) {
                _medicalHistory = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Symptoms'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the symptoms';
                }
                return null;
              },
              onSaved: (value) {
                _symptoms = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Diagnoses'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the diagnoses';
                }
                return null;
              },
              onSaved: (value) {
                _diagnoses = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Treatments'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the treatments';
                }
                return null;
              },
              onSaved: (value) {
                _treatments = value!;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Create a new PatientRecord object
                  PatientRecord newRecord = PatientRecord(
                    patientName: _patientName,
                    medicalHistory: _medicalHistory,
                    symptoms: _symptoms,
                    diagnoses: _diagnoses,
                    treatments: _treatments,
                    dateTime: _dateTime,
                  );
                  // Pass the new record back to the previous screen
                  Navigator.pop(context, newRecord);
                }
              },
              child: Text('Save'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) {
                    setState(() {
                      _dateTime = date;
                    });
                  },
                  onConfirm: (date) {
                    setState(() {
                      _dateTime = date;
                    });
                  },
                );
              },
              child: Text('Select Date and Time'),
            ),
            SizedBox(height: 8),
            Text(
              _dateTime != null ? 'Selected Date and Time: ${_dateTime.toString()}' : 'No Date and Time selected',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
