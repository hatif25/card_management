import 'dart:convert';
import 'package:card_management/utils/re_usable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? filterStartDate;
  String? filterEndDate;
  String? filterCategory;
  String? filterAmountStart;
  String? filterAmountEnd;
  String? filterPayee;

  List<String> categories = ['Entertainment', 'Condiments', 'Grocery'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Apply Filters'),
      // ),
      body:
       ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 15,),
          buildTitleSection(title: 'Filter Expenses'),
          SizedBox(height: 15,),
          TextField(
            onChanged: (value) {
              filterStartDate = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter start date',
              labelText: 'Start Date',
            ),
          ),
          TextField(
            onChanged: (value) {
              filterEndDate = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter end date',
              labelText: 'End Date',
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
          TextField(
            onChanged: (value) {
              filterAmountStart = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter start amount',
              labelText: 'Start Amount',
            ),
          ),
          TextField(
            onChanged: (value) {
              filterAmountEnd = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter end amount',
              labelText: 'End Amount',
            ),
          ),
          TextField(
            onChanged: (value) {
              filterPayee = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter payee',
              labelText: 'Payee',
            ),
          ),
         ElevatedButton(
  onPressed: applyFilters,
  child: Text('Apply'),
),

        ],
      ),
    );
  }

 void applyFilters() async {
  // Create a map to hold the filter parameters
  Map<String, String?> filters = {
    'startDate': filterStartDate,
    'endDate': filterEndDate,
    'category': filterCategory,
    'amountStart': filterAmountStart,
    'amountEnd': filterAmountEnd,
    'payee': filterPayee,
  };

  // Convert null values to empty strings
  filters.forEach((key, value) {
    if (value == null) {
      filters[key] = '';
    }
  });

  final url = "http://192.168.99.173/practice/expense_query.php";

  try {
    final response = await http.post(
      Uri.parse(url),
      body: filters,
    );

    if (response.statusCode == 200) {
      // Handle successful response
      final List<dynamic> expenses = json.decode(response.body);
      // Navigate to a new screen to display filtered expenses
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilteredExpensesScreen(expenses: expenses),
        ),
      );
    } else {
      // Handle error response
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Handle network or server errors
    print('Error: $e');
  }
}
}

class FilteredExpensesScreen extends StatelessWidget {
  final List<dynamic> expenses;

  const FilteredExpensesScreen({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Filtered Expenses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];
            return buildExpensesCard(
              payee: expense['payee'] ?? 'Payee not available',
              amount: expense['amount'] ?? 'Amount not available',
              date: expense['date'] ?? 'Date not available',
              category: expense['categories'] ?? 'Category not available',
              onPressed: () {
                // Handle onTap action if needed
              },
            );
          },
        ),
      ),
    );
  }
}
