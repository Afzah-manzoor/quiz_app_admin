import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_admin/Screens/login/login_screen.dart';

import '../../constants.dart';
import '../../helper/config.dart';
import '../quiz_category/quiz_category.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;
  final DatabaseReference userRefernece =
      FirebaseDatabase.instance.ref().child('Users');
  var userData = [];

  bool isLoading = false;
  String? name;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
  }

  signOutFromFirebase() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              setState(() {
                if (box!.get('login') == true) {
                  signOutFromFirebase();
                  box!.delete('login');

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.routeName,
                    (route) => false,
                  );
                }
              });
            },
          )
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, QuizCategory.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
