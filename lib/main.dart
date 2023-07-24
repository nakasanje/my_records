import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_records/auth/loginscreen.dart';

import 'package:my_records/auth/signup.dart';
import 'package:my_records/notifications.dart';
import 'package:my_records/patient.dart';
import 'package:my_records/providers/settings.dart';
import 'package:my_records/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'auth/verification.dart';
import 'common/global_variables.dart';
import 'doctors.dart';
import 'firebase_options.dart';
import 'notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.configure();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Records',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const //HomePage()
                        Verification();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: GlobalVariables.primaryColor,
                    ),
                  );
                }
                return const LoginScreen();
              }),
          routes: {
            '/doctor-dashboard': (context) => const DoctorDashboard(),
            '/patient-dashboard': (context) => const PatientDashboard(),
            '/home': (context) => const PatientDashboard(),
            '/settings': (context) => const Settings2(),
            '/notifications': (context) => const Notifications(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            SignUpScreen.routeName: (context) => const SignUpScreen(),
          }),
    );
  }
}
