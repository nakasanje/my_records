import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_records/auth/user.dart' as model;
import 'package:my_records/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'auth/loginscreen.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  final userModel = FirebaseAuth.instance.currentUser!;
  FirebaseAuth auth = FirebaseAuth.instance;
  //signout function

  Future<void> signOut() async {
    await auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    model.UserModel user =
        Provider.of<UserProvider>(context, listen: false).getUser;

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: InkWell(
                child: Container(
                  width: 50,
                  height: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    user.photoUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              accountName: Text(user.username),
              accountEmail: Text(user.email),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                signOut();
              },
            ),
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          onTap: (int index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/settings');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/notifications');
            }
          },
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          backgroundColor: const Color.fromARGB(255, 235, 250, 235),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 79, 112, 87),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: Color.fromARGB(255, 79, 112, 87),
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 79, 112, 87),
              ),
              label: 'Settings',
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            //new appbar
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('assets/images/hospital.png'),
                // title: const Text('A g r i S o n i c',
                //     style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              pinned: true,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}
