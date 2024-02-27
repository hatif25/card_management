import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:card_management/models/expenses_model.dart';
import 'package:card_management/utils/re_usable.dart';
import 'package:flutter/material.dart';

class ExpensesWidget extends StatefulWidget {
  const ExpensesWidget({super.key});

  @override
  State<ExpensesWidget> createState() => _ExpensesState();
}

class _ExpensesState extends State<ExpensesWidget> {
  late Future<List<ExpensesInfo>> expensesInfoFuture;

    @override
  void initState() {
    super.initState();
    refreshExpensesInfo();
  }

  void refreshExpensesInfo() {
    setState(() {
      expensesInfoFuture = fetchExpenses();
    });
  }

  Future<List<ExpensesInfo>> fetchExpenses() async {
    final response = await http
        .get(Uri.parse('http://192.168.99.173/practice/expense_details.php'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      List<dynamic> list = json.decode(response.body);
      return List<ExpensesInfo>.from(
          list.map((model) => ExpensesInfo.fromJson(model)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load credit card info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
       Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildTitleSection(title: 'Expenses'),
            Padding(padding: EdgeInsets.all(10)),
            FutureBuilder<List<ExpensesInfo>>(
              future: fetchExpenses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      ExpensesInfo expensesInfo = snapshot.data![index];
                      return _buildExpensesCard(
                        payee: expensesInfo
                            .payee, // replace with actual field name
                        amount: expensesInfo
                            .amount, // replace with actual field name
                        date: expensesInfo
                            .date_of_payment, // replace with actual field name
                        category: expensesInfo
                            .category, // replace with actual field name
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No expenses details available"));
                }
              },
            ),
             buildAddCardButton(
                icon: Icon(Icons.add),
                color: Color(0xFF081603),
                onPressed: () {
                  
                },
              )
          ],
        ),
      ),
      ),
    );
  }
}

Card _buildExpensesCard({
  required String payee,
  required String amount,
  required String date,
  required String category,
}) {
  return Card(
    elevation: 4.0,
    color: Colors.teal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      height: 80,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  payee,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             Spacer(),
              Text(
                '₹$amount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.5, left: 10),
                child: Text(
                  category,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
             Spacer(),
              Text(
                date,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
