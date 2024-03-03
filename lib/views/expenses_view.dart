import 'dart:convert';
import 'package:card_management/utils/add_custom.dart';
import 'package:card_management/utils/search_expenses.dart';
import 'package:card_management/views/add_expense_details.dart';
import 'package:card_management/views/transaction_details.dart';
import 'package:http/http.dart' as http;
import 'package:card_management/models/expenses_model.dart';
import 'package:card_management/utils/re_usable.dart';
import 'package:flutter/material.dart';

class ExpensesWidget extends StatefulWidget {
  const ExpensesWidget({Key? key}) : super(key: key);

  @override
  State<ExpensesWidget> createState() => _ExpensesState();
}

class _ExpensesState extends State<ExpensesWidget> {
  List<ExpensesInfo> _allExpenses = [];
  List<ExpensesInfo> _filteredExpenses = [];
  

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    final response = await http
        .get(Uri.parse('http://192.168.99.173/practice/expense_details.php'));

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      _allExpenses = List<ExpensesInfo>.from(
          list.map((model) => ExpensesInfo.fromJson(model)));
      _filteredExpenses = List.from(_allExpenses);
      setState(() {});
    } else {
      throw Exception('Failed to load credit card info');
    }
  }

void filterExpenses(String searchText) {
  String searchTextLower = searchText.toLowerCase();
  _filteredExpenses = _allExpenses
      .where((expense) =>
          expense.amount.toLowerCase().contains(searchTextLower) ||
          expense.category.toLowerCase().contains(searchTextLower) ||
          expense.payee.toLowerCase().contains(searchTextLower) ||
          expense.date_of_payment.toLowerCase().contains(searchTextLower)
      )
      .toList();
  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              buildTitleSection(title: 'Expenses'),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: IconButton(
                  icon: Icon(Icons.add_circle_outline,color: Colors.black,size: 29),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>   AddExpenses())));
                  }
                ),
              ),
                ],
              ),
              SizedBox(height: 14,),
              TextField(
                onChanged: (value) {
                  filterExpenses(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search expenses',
                  labelText: 'Expenses',
                  suffixIcon: Icon(Icons.search,color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(8)),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredExpenses.length,
                itemBuilder: (context, index) {
                  ExpensesInfo expensesInfo = _filteredExpenses[index];
                  return buildExpensesCard(
                    payee: expensesInfo.payee,
                    amount: expensesInfo.amount,
                    date: expensesInfo.date_of_payment,
                    category: expensesInfo.category,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TransactionDetails()));
                    },
                  );
                },
              ),
              buildAddCardButton(
                icon: Icon(Icons.add),
                color: Color(0xFF081603),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}