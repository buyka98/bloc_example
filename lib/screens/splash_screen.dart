import 'package:bloc_example/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // todo login
                var credential = await FirebaseAuth.instance.signInAnonymously();
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                });
                print("credential $credential");
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "login",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // logging out
                await FirebaseAuth.instance.signOut();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Log out",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
