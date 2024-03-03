import 'package:card_management/utils/search_expenses.dart';
import 'package:card_management/views/add_expense_details.dart';
import 'package:card_management/views/credit_card_view.dart';
import 'package:card_management/views/expenses_view.dart';
import 'package:card_management/views/login_view.dart';
import 'package:card_management/views/main_view.dart';
import 'package:card_management/views/profile_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      color: Colors.deepPurple,
      theme: ThemeData(fontFamily: 'Lato'),
      
      home: Scaffold(
        body: MainWidget(),
        
      ),
      
    );
  }
}