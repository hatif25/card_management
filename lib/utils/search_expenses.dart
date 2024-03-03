// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:card_management/models/card_details_model.dart';
// import 'package:card_management/models/expenses_model.dart';
// import 'package:card_management/utils/re_usable.dart';
// import 'package:card_management/views/transaction_details.dart';
// import 'package:flutter/material.dart';

// class SearchFunction extends StatefulWidget {
//   const SearchFunction({Key? key}) : super(key: key);

//   @override
//   State<SearchFunction> createState() => _SearchFunctionState();
// }

// class _SearchFunctionState extends State<SearchFunction> {
//   late List<ExpensesInfo> _expenses = []; // Your loaded list of expenses
//   String _searchText = '';
  


//     @override
//   void initState() {
//     super.initState();
//     fetchExpenses();
//   }

//   Future<void> fetchExpenses() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.99.173/practice/expense_details.php'));

//     if (response.statusCode == 200) {
//       // If the server returns a 200 OK response,
//       // then parse the JSON.
//       List<dynamic> list = json.decode(response.body);
//       _expenses = List<ExpensesInfo>.from(
//           list.map((model) => ExpensesInfo.fromJson(model)));
//       setState(() {});
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load credit card info');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _filteredExpenses = _expenses
//         .where((expense) =>
//             expense.amount.contains(_searchText) ||
//             expense.category.contains(_searchText) ||
//             expense.payee.contains(_searchText) ||
//             expense.date_of_payment.contains(_searchText)
//         )
//         .toList();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: TextField(
//           onChanged: (value) {
//             setState(() {
//               _searchText = value;
//             });
//           },
//           style: TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             hintText: 'Search for transactions',
//             hintStyle: TextStyle(color: Colors.black),
//             icon: Icon(Icons.search, color: Colors.black),
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: _filteredExpenses.length,
//         itemBuilder: (context, index) {
//           ExpensesInfo expenseInfo = _filteredExpenses[index]; // corrected line
//           return Column(
//             children: [
//               buildExpensesCard(
//                           payee: expenseInfo
//                               .payee, // replace with actual field name
//                           amount: expenseInfo
//                               .amount, // replace with actual field name
//                           date: expenseInfo
//                               .date_of_payment, // replace with actual field name
//                           category: expenseInfo.category,
//                           onPressed: () {
//                             // Add your action here
//                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TransactionDetails()));
//                           }, // replace with actual field name
//                         ),
//               SizedBox(height: 10),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }