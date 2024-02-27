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
  