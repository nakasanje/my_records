import 'package:flutter/material.dart';

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  double _positionX = 0.0;

  void _moveObject() {
    setState(() {
      _positionX = (_positionX == 0.0) ? 200.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Selection'),
      ),
      backgroundColor: const Color.fromARGB(255, 198, 238, 238),
      body: GestureDetector(
        onTap: _moveObject,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage("assets/images/hos.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectionButton(
                role: 'Admin',
                onPressed: () {
                  // Handle admin selection
                  Navigator.pushNamed(context, 'admin');
                },
              ),
              SelectionButton(
                role: 'Nurse',
                onPressed: () {
                  // Handle nurse selection
                  Navigator.pushNamed(context, 'nurse');
                },
              ),
              SelectionButton(
                role: 'Patient',
                onPressed: () {
                  // Handle patient selection
                  Navigator.pushNamed(context, 'patient');
                },
              ),
              SelectionButton(
                role: 'Doctor',
                onPressed: () {
                  // Handle doctor selection
                  Navigator.pushNamed(context, 'doctor');
                },
              ),
              SizedBox(height: 16),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(left: _positionX),
                width: 100.0,
                height: 100.0,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectionButton extends StatelessWidget {
  final String role;
  final VoidCallback onPressed;

  const SelectionButton({
    required this.role,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(role),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SelectionPage(),
  ));
}
