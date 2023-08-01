import 'package:flutter/material.dart';

class SymptomReportingWidget extends StatefulWidget {
  @override
  _SymptomReportingWidgetState createState() => _SymptomReportingWidgetState();
}

class _SymptomReportingWidgetState extends State<SymptomReportingWidget> {
  String selectedSymptom = '';

  List<String> symptoms = [
    'Fever',
    'Cough',
    'Shortness of breath',
    'Fatigue',
    'Headache',
    'Sore throat',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Symptom Reporting',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedSymptom.isEmpty ? null : selectedSymptom,
              hint: Text('Select symptom'),
              onChanged: (newValue) {
                setState(() {
                  selectedSymptom = newValue!;
                });
              },
              items: symptoms.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedSymptom.isNotEmpty) {
                  reportSymptom(selectedSymptom);
                }
              },
              child: Text('Report Symptom'),
            ),
          ],
        ),
      ),
    );
  }

  void reportSymptom(String symptom) {
    // Perform the necessary logic to report the symptom to the backend or handle it locally
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Symptom Reported'),
          content: Text('You have reported the symptom: $symptom'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}