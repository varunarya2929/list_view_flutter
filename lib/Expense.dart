class Expense {
  final int id;
  final String expense;
  final double amount;

  const Expense(
      {required this.id, required this.expense, required this.amount});

  Map<String, dynamic> toMap() {
    return {'expense': expense, 'amount': amount};
  }
}
