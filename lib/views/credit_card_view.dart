import 'dart:convert';
import 'package:card_management/models/card_details_model.dart';
import 'package:card_management/views/add_card_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:card_management/utils/re_usable.dart';

class CreditCardsPage extends StatefulWidget {
  final String loggedInUsername;

  const CreditCardsPage({Key? key, required this.loggedInUsername}) : super(key: key);

  @override
  State<CreditCardsPage> createState() => _CreditCardsPageState();
}

class _CreditCardsPageState extends State<CreditCardsPage> {
  late Future<List<CreditCardInfo>> creditCardInfoFuture;


  @override
  void initState() {
    super.initState();
    refreshCreditCardInfo();
  }

  void refreshCreditCardInfo() {
    setState(() {
      creditCardInfoFuture = fetchCreditCardInfo();
    });
  }

Future<List<CreditCardInfo>> fetchCreditCardInfo() async {
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
    return List<CreditCardInfo>.from(
        list.map((model) => CreditCardInfo.fromJson(model)));
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
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitleSection(
                title: "Card Details",
              ),
              Padding(padding: EdgeInsets.all(10)),
           FutureBuilder<List<CreditCardInfo>>(
  future: creditCardInfoFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text("${snapshot.error}"));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text("No card details available"));
    } else {
      List<CreditCardInfo> creditCardInfoList = snapshot.data!;
      print(creditCardInfoList[0].cardHolderName);
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          CreditCardInfo cardInfo = snapshot.data![index];
          return Column(
            children: [
              _buildCreditCard(
                color: Color(0xFF090943),
                cardExpiration: cardInfo.expiryDate,
                cardHolder: cardInfo.cardHolderName,
                cardNumber: cardInfo.cardNumber,
                bankName: cardInfo.bankName,
              ),
              SizedBox(height: 10),
            ],
          );
        },
      );
    }
  },
)
,
              buildAddCardButton(
                icon: Icon(Icons.add),
                color: Color(0xFF081603),
                onPressed: () {
                  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCardDetails(loggedInUsername: widget.loggedInUsername),
      ),
    ).then((_) => refreshCreditCardInfo());
  },
)
            ],
          ),
        ),
      ),
    );
  }


    Card _buildCreditCard({
    required Color color,
    required String cardNumber,
    required String cardHolder,
    required String cardExpiration,
    required String bankName,
  }) {
    return Card(
      elevation: 8.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            /* Here we are going to place the _buildLogosBlock */
            Row(
              /*1*/
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  bankName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'CourrierPrime',
                  ),
                ),
                Image.asset(
                  "assets/images/mastercard.png",
                  height: 50,
                  width: 50,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              /* Here we are going to place the Card number */
              child: Text(
                formatCardNumber(cardNumber),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'CourrierPrime',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /* Here we are going to place the _buildDetailsBlock */
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(
                  label: 'VALID THRU',
                  value: cardExpiration,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




  

  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }


  }


String formatCardNumber(String cardNumber) {
  cardNumber = cardNumber.replaceAll(' ', ''); // remove existing spaces if any
  String formatted = '';
  for (int i = 0; i < cardNumber.length; i++) {
    if (i % 4 == 0 && i != 0) {
      formatted += ' '; // add a space every 4 digits
    }
    formatted += cardNumber[i];
  }
  return formatted;
}

