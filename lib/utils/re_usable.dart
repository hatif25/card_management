import 'package:flutter/material.dart';

Column buildTitleSection({String title = 'Build'}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 16.0),
        child: Text(
          '$title',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

  Container buildAddCardButton({
    required Icon icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 2.0,
        onPressed: onPressed,
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }
  




  Card buildExpensesCard({
  required String payee,
  required String amount,
  required String date,
  required String category,
  required Function() onPressed,
}) {
  return Card(
    elevation: 4.0,
    color: Colors.teal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: GestureDetector(
      onTap: onPressed,
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
    ),
  );
}
