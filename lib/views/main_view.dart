import 'package:card_management/views/credit_card_view.dart';
import 'package:card_management/views/expenses_view.dart';
import 'package:card_management/views/login_view.dart';
import 'package:card_management/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loggedInUsername = Provider.of<UserProvider>(context).uname;

    final List<Widget> _children = [
      CreditCardsPage(loggedInUsername: loggedInUsername),
      ExpensesWidget(loggedInUsername: loggedInUsername),
      ProfileView(loggedInUsername: loggedInUsername),
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
            icon: Icon(Icons.credit_card_outlined),
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
