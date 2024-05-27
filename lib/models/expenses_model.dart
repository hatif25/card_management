class ExpensesInfo {
  final String trsn_id; // Add the trsn_id field

  // Other fields
  final String payee;
  final String amount;
  final String date_of_payment;
  final String category;

  ExpensesInfo({
    required this.trsn_id, // Update the constructor
    required this.payee,
    required this.amount,
    required this.date_of_payment,
    required this.category,
  });

  // Add a getter for trsn_id
  String get trsnId => trsn_id;

  // Add a factory method to convert JSON to ExpensesInfo object
  factory ExpensesInfo.fromJson(Map<String, dynamic> json) {
    return ExpensesInfo(
      trsn_id: json['trsn_id'], // Update the field name according to your JSON structure
      payee: json['payee'],
      amount: json['amount'],
      date_of_payment: json['date_of_payment'],
      category: json['category'],
    );
  }
}
