import 'dart:convert';

import 'package:card_management/models/card_details_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  TextEditingController samount = new TextEditingController();
  String? selectedCard;
  TextEditingController t_id = new TextEditingController();
  TextEditingController category = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController payee = new TextEditingController();

  List<CreditCardInfo> creditCardInfoList =
      []; // Define creditCardInfoList here

  @override
  void initState() {
    super.initState();
    fetchCreditCardInfo();
  }

  Future<void> fetchCreditCardInfo() async {
    final response = await http
        .get(Uri.parse('http://192.168.99.173/practice/card_details.php'));

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      creditCardInfoList = List<CreditCardInfo>.from(
          list.map((model) => CreditCardInfo.fromJson(model)));
      setState(() {});
    } else {
      throw Exception('Failed to load credit card info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.number, // Use keyboardType propert
                decoration: InputDecoration(
                  hintText: 'Enter the amount',
                  labelText: 'Spent Amount',
                  prefixIcon: Icon(
                    Icons.currency_rupee,
                    color: Colors.blue,
                  ),
                ),
              ),
              TextFormField(
                controller: t_id,
                decoration: InputDecoration(
                  hintText: 'Enter the transaction ID',
                  labelText: 'Transaction ID',
                  prefixIcon: Icon(
                    Icons.confirmation_number,
                    color: Colors.blue,
                  ),
                  // ...
                ),
              ),
              TextFormField(
                controller: category,
                decoration: InputDecoration(
                  hintText: 'Enter the category',
                  labelText: 'Category',
                  prefixIcon: Icon(
                    Icons.category,
                    color: Colors.blue,
                  ),
                  // ...
                ),
              ),
              TextFormField(
                controller: date,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'Enter the date',
                  labelText: 'Date',
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: Colors.blue,
                  ),
                  // ...
                ),
              ),
              TextFormField(
                controller: payee,
                decoration: InputDecoration(
                  hintText: 'Enter the payee',
                  labelText: 'Payee',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  // ...
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: selectedCard,
                items: creditCardInfoList.map((CreditCardInfo cardInfo) {
                  // Use creditCardInfoList here
                  return DropdownMenuItem<String>(
                    value: cardInfo.cardNumber,
                    child: Text(cardInfo.cardNumber),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCard = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select Card',
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 9,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Insert Expenses Details',
                  style: TextStyle(color: Colors.white),

                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
