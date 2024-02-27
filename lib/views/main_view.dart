import 'package:card_management/views/credit_card_view.dart';
import 'package:card_management/views/expenses_view.dart';
import 'package:card_management/views/profile_view.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MainWidget> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    CreditCardsPage(),
    ExpensesWidget(),
    ProfileView(),
    // Add more pages in this list
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

TextStyle selectedLabelStyle() {
  return TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        iconSize: 35,
        selectedLabelStyle: selectedLabelStyle(),
        fixedColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.green), // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined,),
            label: 'My Cards',
            
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: 'Expenses',
          ),

          
          
          
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
          // Add more items for more tabs
        ],
      ),
    );
  }
}