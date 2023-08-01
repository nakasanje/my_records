import 'package:flutter/material.dart';

class HealthTrackingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Health Tracking',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          HealthParameterCard(
            parameterName: 'Weight',
            parameterValue: '70 kg',
          ),
          SizedBox(height: 16),
          HealthParameterCard(
            parameterName: 'Blood Pressure',
            parameterValue: '120/80 mmHg',
          ),
          SizedBox(height: 16),
          HealthParameterCard(
            parameterName: 'Blood Sugar',
            parameterValue: '100 mg/dL',
          ),
          SizedBox(height: 16),
          HealthParameterCard(
            parameterName: 'Pain Level',
            parameterValue: '3/10',
          ),
        ],
      ),
    );
  }
}

class HealthParameterCard extends StatelessWidget {
  final String parameterName;
  final String parameterValue;

  const HealthParameterCard({
    required this.parameterName,
    required this.parameterValue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              parameterName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              parameterValue,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
