import 'package:bloc_example/screens/home/home_screen.dart';
import 'package:bloc_example/screens/todo/todo_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final int? number;
  const MainScreen({super.key, this.number});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: "gallery"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "user")
        ],
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: [
          HomeScreen(),
          TodoScreen(),
          TodoScreen(),
        ][selectedIndex],
      ),
    );
  }
}
