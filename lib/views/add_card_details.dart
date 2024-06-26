import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCardDetails extends StatelessWidget {
  final String loggedInUsername;

  AddCardDetails({Key? key, required this.loggedInUsername}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cNumber = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController bankname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  TextFormField(
                    controller: cNumber,
                    decoration: InputDecoration(
                      hintText: 'Enter your card number',
                      labelText: 'Card Number',
                      prefixIcon: Icon(
                        Icons.credit_card,
                        color: Colors.blue,
                      ),
                      errorStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardNumberInputFormatter(),
                    ],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.replaceAll(' ', '').length != 16) {
                        return 'Card number must be 16 digits';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        hintText: "Full name",
                        labelText: 'Enter your name',
                        prefixIcon: Icon(
                          Icons.supervised_user_circle_outlined,
                          color: Colors.blue,
                        ),
                        errorStyle: TextStyle(fontSize: 18.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: bankname,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: "Enter your bank name",
                            labelText: 'Bank Name',
                            prefixIcon: Icon(
                              Icons.business_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: expiry,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          decoration: const InputDecoration(
                            hintText: "YYYY",
                            labelText: 'Enter expiry year',
                            prefixIcon: Icon(
                              Icons.calendar_today_sharp,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  var response = await http.post(
                    Uri.parse(
                        'http://192.168.205.173/practice/insert_cardDetails.php'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'uname': loggedInUsername,
                      'cardNumber': cNumber.text,
                      'expiry': expiry.text,
                      'name': name.text,
                      'bankName': bankname.text,
                    }),
                  );

                  print('Response status code: ${response.statusCode}');
                  print('Response body: ${response.body}');

                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Card details inserted successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    print('Response data: ${response.body}');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Failed to insert card details, card may already exist '),
                        backgroundColor: Colors.red,
                      ),
                    );
                    throw Exception(
                        'Failed to load data: ${response.body}');
                  }
                }
              },
              child: const Text('Insert Card Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
