

class ExpensesInfo {
  final String payee;
  final String category;
  final String amount;
  final String date_of_payment;

  ExpensesInfo({
    required this.payee,
    required this.category,
    required this.amount,
    required this.date_of_payment,
  });

  factory ExpensesInfo.fromJson(Map<String, dynamic> json) {
    return ExpensesInfo(
      payee: json['payee'],
      category: json['category'],
      amount: json['amount'],
      date_of_payment: json['date_of_payment'],
    );
  }
}