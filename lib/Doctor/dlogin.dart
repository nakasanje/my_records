import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homerex/Patient/dpatient.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homerex/Doctor/bill.dart';

import 'package:homerex/Doctor/dashboard.dart';
class DoctorLoginPage extends StatefulWidget {

 final String email;
  
  DoctorLoginPage({required this.email});
  
  @override
  _DoctorLoginPageState createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null && userCredential.user!.emailVerified) {
        // Email is verified and user is logged in
        // Redirect the doctor to the dashboard
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDashboard(email: userCredential.user!.email!),
          ),
        );
      } else {
       // Email is not verified, show a snackbar or dialog to inform the user
          //ScaffoldMessenger.of(context).showSnackBar(
           // SnackBar(
            //  content: Text('Please verify your email before logging in.'),
            //  duration: Duration(seconds: 5),
            //  ),
            //  );
      }
    } catch (e) {
      // Handle login errors
      print('Login Error: $e');
      // You can show a snackbar or dialog here to inform the user about the error
    }
  }
   Future<void> _forgotPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent. Please check your email.'),
          duration: Duration(seconds: 50),
        ),
      );
   
   
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send password reset email. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Login'),
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
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: _forgotPassword,
              child: Text('Forgot Password'),
            ),
          ],
        ),
      ),
    );
  }
}
