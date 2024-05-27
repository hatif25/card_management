import 'dart:convert';

import 'package:card_management/models/transaction_model.dart';
import 'package:card_management/utils/re_usable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionDetails extends StatefulWidget {
  final String trsnId;

  const TransactionDetails({Key? key, required this.trsnId}) : super(key: key);

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  late Future<List<TransactionDetailsModel>> _transactionDetails;

  @override
  void initState() {
    super.initState();
    _transactionDetails = fetchTransactionDetails(widget.trsnId);
  }

  Future<List<TransactionDetailsModel>> fetchTransactionDetails(String trsnId) async {
    final response = await http.get(Uri.parse('http://192.168.205.173/practice/show_transactionDetails.php?trsn_id=$trsnId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data is List) {
        return data.map((item) => TransactionDetailsModel.fromJson(item)).toList();
      } else {
        throw Exception('Data is not a list');
      }
    } else {
      throw Exception('Failed to load transaction details: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleSection(title: 'Transaction Details'),
          Expanded(
            child: FutureBuilder<List<TransactionDetailsModel>>(
              future: _transactionDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final transactionData = snapshot.data![index];
                      return Card(
                        color: Colors.teal,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Card Number: ${transactionData.cardNumber ?? 'N/A'}',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                'Amount: Rs. ${transactionData.amount ?? 'N/A'}',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                'Transaction ID: ${transactionData.transactionId ?? 'N/A'}',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                'To: ${transactionData.payee ?? 'N/A'}',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                'Date: ${transactionData.date ?? 'N/A'}',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                'Category: ${transactionData.category ?? 'N/A'}',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}