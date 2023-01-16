import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expenses_app/widgets/user_transactions.dart';

import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: "t1", title: "New Shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: "t2", title: "New Phone", amount: 169.99, date: DateTime.now()),
  ];

  // String value;
  // String title;

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Planer wydatków"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const[
              Card(
                child: Text("Chart"),
              ),
              UserTransactions(),
            ],
          ),
        ),
      ),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}
