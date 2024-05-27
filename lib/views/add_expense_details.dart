import 'dart:convert';

import 'package:card_management/models/card_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AddExpenses extends StatefulWidget {
  final String loggedInUsername;

  const AddExpenses({Key? key, required this.loggedInUsername}) : super(key: key);

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
    String? filterCategory;

  List<String> categories = ['Entertainment', 'Condiments', 'Grocery'];
  List<CreditCardInfo> creditCardInfoList =
      []; // Define creditCardInfoList here

  @override
  void initState() {
    super.initState();
    fetchCreditCardInfo();
    
  }
  

Future<void> fetchCreditCardInfo() async {
  final url = Uri.parse('http://192.168.205.173/practice/card_details.php')
      .replace(queryParameters: {'uname': widget.loggedInUsername});
      print(widget.loggedInUsername);

  final response = await http.get(url);

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response,
    // then parse the JSON.
    List<dynamic> list = json.decode(response.body);
    List<CreditCardInfo> fetchedCardInfo = List<CreditCardInfo>.from(
        list.map((model) => CreditCardInfo.fromJson(model)));

    setState(() {
      creditCardInfoList = fetchedCardInfo;
    });
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load credit card info');
  }
}
Future<void> insertExpenseDetails() async {
  // Check if all required fields are entered
  print('Selected Card: $selectedCard'); 
  print('Selected category: $filterCategory');
  if (selectedCard == null ||
      selectedCard!.isEmpty || // Check if selectedCard is not empty
      t_id.text.isEmpty ||
      date.text.isEmpty ||
      samount.text.isEmpty ||
      payee.text.isEmpty ||
       (filterCategory == null || filterCategory!.isEmpty)) {
    // Show a snackbar with red background for missing fields
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please fill in all the required fields.'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  var response = await http.post(
    Uri.parse('http://192.168.205.173/practice/insert_expenses.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'trsn_id': t_id.text,
      'cardNumber': selectedCard,
      'dateOfPayment': date.text,
      'amount': samount.text,
      'payee': payee.text,
      'category': filterCategory,
    }),
  );

  if (response.statusCode == 200) {
    // Show a snackbar with green background for successful insertion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense details inserted successfully'),
        backgroundColor: Colors.green,
      ),
    );
  } else {
    // Show a snackbar with red background for failed insertion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to insert expense details, Transaction id may already exist'),
        backgroundColor: Colors.red,
      ),
    );
    throw Exception('Failed to load data: ${response.body}');
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
                controller: samount,
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
                      DropdownButtonFormField<String>(
            value: filterCategory,
            items: categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                filterCategory = newValue;
              });
            },
            decoration: InputDecoration(
              labelText: 'Select Category',
            ),
          ),
              TextFormField(
              controller: date,
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[^\d-]')), // Only allow digits and hyphens
                LengthLimitingTextInputFormatter(10), // Limit to 10 characters
                _DateInputFormatter(), // Format the date as YYYY-MM-DD
              ],
              decoration: InputDecoration(
                hintText: 'Enter the date (YYYY-MM-DD)',
                labelText: 'Date',
                prefixIcon: Icon(
                  Icons.date_range,
                  color: Colors.blue,
                ),
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
                onPressed: () {
                   insertExpenseDetails(); 
                },
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

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var dateText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (dateText.length > 8) {
      dateText = dateText.substring(0, 8);
    }

    var newText = '';
    for (var i = 0; i < dateText.length; i++) {
      if (i == 4 || i == 6) {
        newText += '-';
      }
      newText += dateText[i];
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}