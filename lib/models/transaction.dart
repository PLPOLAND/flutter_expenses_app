import 'package:flutter/foundation.dart';//for @required

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction({@required this.id, @required this.title, @required this.amount, @required this.date});
}
