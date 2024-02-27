class CreditCardInfo {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String bankName;

  CreditCardInfo({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.bankName,
  });

  factory CreditCardInfo.fromJson(Map<String, dynamic> json) {
    return CreditCardInfo(
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      cardHolderName: json['cardHolderName'],
      bankName: json['bankName'],
    );
  }
}
