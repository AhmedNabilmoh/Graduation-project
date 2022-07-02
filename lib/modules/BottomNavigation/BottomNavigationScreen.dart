import 'package:flutter/material.dart';
import 'package:napta/modules/Model/ModelScreen.dart';
import 'package:napta/modules/Posts/PostScreens.dart';
import 'package:napta/modules/calcolatur/Calculator.dart';
import 'package:napta/modules/profile/profile.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final _screens = [
    {
      'screen': PostScreen(),
    },
    {
      'screen': CalculatorScreen(),
    },
    {
      'screen': ModelScreen(),
    },
    {
      'screen': Profile(),
    }
  ];
  int _selectedScreenIndex = 0;
  void _selectScreen(int value) {
    setState(() {
      _selectedScreenIndex = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        selectedFontSize: 15,
        currentIndex: _selectedScreenIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Posts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: "Calculator"),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Model",
            /* title: Text("Image Analysis",
                  style: TextStyle(fontFamily: 'Lato', color: Colors.green))*/
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
