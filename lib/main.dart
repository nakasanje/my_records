import 'package:flutter/material.dart';
import 'package:homerex/screens/admin.dart';
import 'package:homerex/screens/dnurse.dart';
import 'package:homerex/screens/dpatient.dart';
import 'package:homerex/screens/dscreen.dart';
import 'package:homerex/screens/firestore.dart';
import 'package:homerex/screens/selection.dart';
import 'package:homerex/screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:homerex/screens/signp.dart';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:homerex/Doctor/dashboard.dart'; // Import PatientsPage from dashboard.dart
import 'package:homerex/Patient/dpatient.dart';
import 'package:homerex/Doctor/editpatient.dart';
import 'package:homerex/Doctor/add.dart';
import 'package:homerex/Doctor/bill.dart';
import 'package:homerex/Doctor/patient_details.dart'; // Import the PatientDetailsPage class
import 'package:homerex/Doctor/dlogin.dart';

 Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
    options: FirebaseOptions(
       apiKey: 'AIzaSyCVdeATQYX01ZRqKZu577u4OHqbTLGMTAM',
       appId: '1:948370526957:web:55de6d8b932e1a923132e4',
       messagingSenderId: '948370526957',
       projectId: 'homerex-3a1f9',
       ),
  );
  runApp(HealthRecordsApp());
}
class HealthRecordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Records App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupPage(),
       onGenerateRoute: (settings) {
  if (settings.name == 'patientDetails') {
    final patient = settings.arguments as Patient?;
    if (patient != null) {
      return MaterialPageRoute(
        builder: (context) => PatientDetailsPage(patient: patient),
      );
    }
  }
  // Handle other routes if needed
  return null;
},
      routes: {
       // '': (context) => DoctorDashboard(),
        'selection': (context) => SelectionPage(),
        'admin': (context) => AdminScreen(),
        'doctor': (context) => DoctorScreen(),
        'patient': (context) => PatientScreen(),
        'nurse': (context) => NurseScreen(),
        'patients': (context) => PatientsPage(),
         'add': (context) =>  AddPatientPage(),
                  'bill': (context) => SignupPage(),
                //  '/': (context) => SignupPage(),
        'doctor_dashboard': (context) => DoctorDashboard(email: ModalRoute.of(context)?.settings.arguments as String),
        'patient_dashboard': (context) => PatientDashboard(email: ModalRoute.of(context)?.settings.arguments as String),
        //'patientDetails': null,
 // Update the route for PatientDetailsPage
        //'patientDetails': (context) {
          //final patient = ModalRoute.of(context)!.settings.arguments as Patient;
          //return PatientDetailsPage(patient: patient);
        //},      
      },
      
      
      
    );
  }
}
