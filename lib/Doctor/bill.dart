import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:homerex/Doctor/dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:homerex/Patient/dpatient.dart';

import 'package:homerex/Doctor/plogin.dart'; // Import the DoctorLoginPage class

import 'package:homerex/Doctor/dlogin.dart'; // Import the PatientLoginPage class




// Constants for user types
const String userTypeDoctor = 'Doctor';
const String userTypePatient = 'Patient'; 

class SignupPage extends StatefulWidget {


  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
 // String _userType = 'Doctor';
  String _userType = userTypeDoctor; // Set the default user type to 'Doctor'
  
  void _redirectToDashboard(User user, String userType) {
    if (userType == userTypeDoctor) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorLoginPage(email: user.email!),
        ),
      );
    } else if (userType == userTypePatient) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PatientLoginPage(email: user.email!),
        ),
      );
    }
  }
  
  Future<bool> checkEmailRegisteredWithGoogle(String email) async {
     try {
       final response = await http.get(
         Uri.parse('https://accounts.google.com/SignUp?EmailExists='),
         headers: {
           'Accept': 'application/json',
         },
       );
       // Parse the response and determine if the email is registered
       // Return true if the email is registered, false otherwise
       // Example code:
       return response.statusCode == 200;
     } catch (e) {
       print('Error checking email registration with Google: $e');
       return false;
     }
   }
   
   // Rename the existing _signup() method to _register()
Future<void> _register() async {
  // ... your existing code ...
}

// Add another method for email verification
Future<void> _sendVerificationEmail() async {
  try {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print('Verification email sent to ${user.email}');
    } else {
      print('User is already verified or email is null');
    }
  } catch (e) {
    print('Error sending verification email: $e');
  }
}
   
   
   
    void _showWelcomeMessage(String userType, String email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Welcome, $userType $email!'),
        content: Text('You have successfully signed up as a $userType.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
  
Future<void> _signup() async {
    try {
      if (_emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

      
    // Check if the email is registered with Google
    bool isRegistered = await checkEmailRegisteredWithGoogle(_emailController.text);
    if (!isRegistered) {
      print('Email is not registered with Google');
      return;
    }

      // Proceed with the user signup using Firebase Auth and Firestore
      if (_isEmailValid(_emailController.text.trim())) {
        if (_userType == 'Doctor') {
          signUpAsDoctor(_emailController.text.trim(), _passwordController.text.trim(), 'Doctor Name');
        } else if (_userType == 'Patient') {
          signUpAsPatient(_emailController.text.trim(), _passwordController.text.trim(), 'Patient Name');
        }
      } else {
        print('Invalid email format');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup Error: $e'),
          duration: Duration(seconds: 3),
        ),
      );
      // Handle any errors during signup here
    }
  }
  

  bool _isEmailValid(String email) {
    // Simple email format validation
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$').hasMatch(email);
  }

  void signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send verification email to the user
      await userCredential.user?.sendEmailVerification();

      // Notify the user to check their email for verification
       await _sendVerificationEmail();

      // Listen for changes in the user's email verification status
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null && user.emailVerified) {
          // Email is verified
          // Proceed with your desired logic
        } else {
          // Email is not verified or user is signed out
          // Handle accordingly
        }
      });
    } catch (e) {
      // Handle any errors during signup
      print(e.toString());
    }
  }

  void signUpAsDoctor(String email, String password, String name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


    // Send verification email to the doctor
    await userCredential.user?.sendEmailVerification();



    _redirectToDashboard(userCredential.user!, 'Doctor');
      // Send verification email to the doctor
      await userCredential.user?.sendEmailVerification();

      // Notify the doctor to check their email for verification
       await _sendVerificationEmail();

      // Create a new document for the doctor in Firebase Firestore
      FirebaseFirestore.instance.collection('doctors').doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,
        // Add other doctor details here
      });

      // Listen for changes in the doctor's email verification status
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null && user.emailVerified) {
          // Email is verified
          // Redirect the doctor to the new dashboard
          _redirectToDashboard(user,_userType);
        } else {
          // Email is not verified or doctor is signed out
          // Handle accordingly
        }
      });
    } catch (e) {
      // Handle any errors during signup
      print(e.toString());
    }
  }

  void signUpAsPatient(String email, String password, String name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
       // Send verification email to the patient
    await userCredential.user?.sendEmailVerification();
       _redirectToDashboard(userCredential.user!, 'Patient');
       
      // Send verification email to the patient
      //await userCredential.user?.sendEmailVerification();

      // Notify the patient to check their email for verification

      // Create a new document for the patient in Firebase Firestore
      FirebaseFirestore.instance.collection('patients').doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,
        // Add other patient details here
      });

      // Listen for changes in the patient's email verification status
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null && user.emailVerified) {
          // Email is verified
          // Redirect the patient to the new dashboard
          _redirectToDashboard(user,_userType);
        } else {
          // Email is not verified or patient is signed out
          // Handle accordingly
        }
      });
    } catch (e) {
      // Handle any errors during signup
      print(e.toString());
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _userType,
              onChanged: (String? newValue) {
                setState(() {
                  _userType = newValue!;
                });
              },
              items: <String>['Doctor', 'Patient']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: () {
    if (_isEmailValid(_emailController.text.trim())) {
      if (_userType == 'Doctor') {
        signUpAsDoctor(_emailController.text.trim(), _passwordController.text.trim(), 'Doctor Name');
      } else if (_userType == 'Patient') {
        signUpAsPatient(_emailController.text.trim(), _passwordController.text.trim(), 'Patient Name');
      }
    } else {
      // Show SnackBar when email is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email format'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  },
  child: Text('Signup'),
),
  SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // Navigate to the DoctorLoginPage when the doctor login link is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorLoginPage(email: _emailController.text.trim()),
                ),
              );
            },
            child: Text('Doctor Login'),
          ),
          TextButton(
            onPressed: () {
              // Navigate to the PatientLoginPage when the patient login link is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientLoginPage(email: _emailController.text.trim()),
                ),
              );
            },
            child: Text('Patient Login'),
          ),
          ],
        ),
      ),
    );
  }
}


