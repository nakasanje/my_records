import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homerex/screens/admin.dart';

class SigninFormA extends StatelessWidget {
  const SigninFormA({
    Key? key,
    required this.signInFormKey,
    required this.idController,
    required this.passwordController,
  }) : super(key: key);

  final GlobalKey<FormState> signInFormKey;
  final TextEditingController idController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: signInFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'ID',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter ID';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: const Color(0xFF13548A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminScreen()),
                  );
                },
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.1,
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
