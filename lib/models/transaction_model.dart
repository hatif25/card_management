class TransactionDetailsModel {
  // final String bankName;
  final String cardNumber;
  final int amount;
  final String transactionId;
  final String payee;
  final String date;
  final String category;

  TransactionDetailsModel({
    // required this.bankName,
    required this.cardNumber,
    required this.amount,
    required this.transactionId,
    required this.payee,
    required this.date,
    required this.category,
  });

  factory TransactionDetailsModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailsModel(
      transactionId: json['trsn_id'],
      cardNumber: json['card_no'],
      amount: json['amount'],
      payee: json['payee'],
      date: json['date_of_payment'],
      category: json['category'],
    );
  }
}
